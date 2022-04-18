#!/usr/bin/env python

import csv
import sqlite3
import argparse
import fileinput

parser = argparse.ArgumentParser()
parser.add_argument("-d", "--database", required = True, help = "SQLite database file to insert into")
parser.add_argument("-t", "--table", required = True, help = "SQLite table to insert into")
parser.add_argument("-s", "--schema", help = "Table schema in 'name datatype, name datatype, ...' format")
parser.add_argument("--delimiter", default = ",", help = "Columns are delimited by this")
parser.add_argument("--quotechar", default = '"', help = "Columns are optionally enclosed by this")
parser.add_argument("--commit-interval", type = int, default = 1000, help = "How often to commit partial loads, zero for disabled")
args, argv_leftovers = parser.parse_known_args()



conn = sqlite3.connect(args.database)
cursor = conn.cursor()

if args.schema:
    cursor.execute("CREATE TABLE IF NOT EXISTS {} ({})".format(args.table, args.schema))


reader = csv.reader(
    fileinput.input(argv_leftovers),
    delimiter = args.delimiter,
    quotechar = args.quotechar,
)


for rownum, row in enumerate(reader, start = 1):
    sql = "INSERT INTO {} VALUES ( {} )".format(
        args.table,
        ",".join(["?"] * len(row))
    )
    cursor.execute(sql, row)

    if args.commit_interval and rownum % args.commit_interval == 0:
        print "Committed at {} rows".format(rownum)
        conn.commit()

conn.commit()

print "Loaded {} rows".format(rownum)
