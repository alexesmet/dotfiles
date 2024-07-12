#!/usr/bin/sh



# A POSIX variable for getopts
OPTIND=1

# Initialize our own variables:
FILE_NAME='~/Documents/Accounting/root.beancount'
USE_CSV=0
MYTMPDIR="$(mktemp -d)"
trap 'rm -rf -- "$MYTMPDIR"' EXIT

while getopts "cf:" opt; do
  case "$opt" in
    c) USE_CSV=1
      ;;
    f) FILE_NAME=$OPTARG
      ;;
  esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift



bean-query "$FILE_NAME" 'SELECT
  YEAR(date) AS year,
  MONTH(date) AS month,
  SUM(NUMBER(convert(cost(position), "USD"))) AS income
WHERE
  account ~ "^Income"
GROUP BY year, month ORDER BY year, month' -o $MYTMPDIR/gross.csv -f csv

bean-query "$FILE_NAME" 'SELECT
  YEAR(date) AS year,
  MONTH(date) AS month,
  SUM(NUMBER(convert(cost(position), "USD"))) AS taxes
WHERE
account ~ "Expenses:Business:(Tax|Service)"
GROUP BY year, month ORDER BY year, month' -o $MYTMPDIR/taxes.csv -f csv

bean-query "$FILE_NAME" 'SELECT
  YEAR(date) AS year,
  MONTH(date) AS month,
  SUM(NUMBER(convert(cost(position), "USD"))) AS taxes
WHERE
  account ~ "Expenses:" AND NOT account ~ "Expenses:Business:(Tax|Service)"
GROUP BY year, month ORDER BY year, month' -o $MYTMPDIR/expenses.csv -f csv

awk -F, '
BEGIN {
    FS = ",";
    OFS = ",";
    print "year,month,total_income_usd,total_taxes_usd,net_income_usd";
}

FNR == NR && NR > 1 {
    tax[$1+0 FS $2+0] = $3;
    next;
}

FNR > 1{
    key = $1+0 OFS $2+0;
    total_income = -$3;
    total_taxes = (key in tax) ? tax[key] : 0;
    net_income = total_income - total_taxes;
    printf "%d,%d,%.2f,%.2f,%.2f\n", $1, $2, total_income, total_taxes, net_income;
}
' "$MYTMPDIR/taxes.csv" "$MYTMPDIR/gross.csv"  > "$MYTMPDIR/income.csv"

awk -F, '
BEGIN {
    OFS = ",";
    print "year,month,gross,tax,net,expenses,saved,rate";
}

FNR == NR && NR > 1 {
    myarr[$1+0 OFS $2+0] = $3;
    next;
}

FNR > 1 {
    expense = myarr[$1+0 OFS $2+0];
    net_income = $5;
    saved = net_income - expense;
    rate = saved * 100 / net_income;
    printf "%d,%d,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f\n", $1, $2, $3, $4, net_income, expense, saved, rate;
}
' "$MYTMPDIR/expenses.csv" "$MYTMPDIR/income.csv" > "$MYTMPDIR/results.csv"

if [ $USE_CSV == 1 ]; then
    cat "$MYTMPDIR/results.csv"
else
    cat "$MYTMPDIR/results.csv" | awk -F, 'NR==1 { print $0 } NR>1 { $8=$8"%"; for (i=1;i<=NF;i++) printf "%s",$i FS; print "" }' | column  -s, -t -R 1-8
fi


