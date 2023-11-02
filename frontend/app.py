import streamlit as st
from create import create
from database import create_table
from delete import delete
from read import read
from update import update
from pie import pie
from query_exec import query

def main():
    st.title("BOOK PUBLISHING DATABASE MANAGEMENT SYSTEM -- PES1UG20CS359")
    menu = ["INSERT", "VIEW", "EDIT", "REMOVE","VIEW PIE-CHART","CUSTOM QUERY"]
    choice = st.sidebar.selectbox("Menu", menu)
    create_table()
    if choice == "INSERT":
        st.subheader("Enter subject Details:")
        create()
    elif choice == "VIEW":
        st.subheader("View subject:")
        read()
    elif choice == "EDIT":
        st.subheader("Update subject details:")
        update()
    elif choice == "REMOVE":
        st.subheader("Delete from subject:")
        delete()
    elif choice == "VIEW PIE-CHART":
        st.subheader("View data on number of books in each genre:")
        pie()
    #add
    elif choice == "CUSTOM QUERY":
        st.subheader("Enter query to execute in SQL syntax:")
        query()
    #addend
    else:
        st.subheader("About tasks")
if __name__ == '__main__':
    main()