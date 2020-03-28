#!/usr/bin/python

import psycopg2
hostname = 'dvd_rental_db'
username = 'postgres'
password = 'password'
database = 'dvdrental'
query_file = '/dvdrental/query.sql'


def doQuery(conn):
    cur = conn.cursor()

    cur.execute("SELECT * FROM film")

    for result in cur.fetchall():
        print(result)


print("Using psycopg2…")
myConnection = psycopg2.connect(
    host=hostname, user=username, password=password, dbname=database)
doQuery(myConnection)
myConnection.close()
