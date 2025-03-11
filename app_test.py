import mysql.connector
from flask import Flask, render_template, request, redirect, url_for


mydb = mysql.connector.connect(
  host="localhost",
  user="yourusername",
  password="yourpassword",
  database="cross"
)
