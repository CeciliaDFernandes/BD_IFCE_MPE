import mysql.connector
from mysql.connector import Error

def conectar_banco():
    try:
        conexao = mysql.connector.connect(
            host="localhost",
            user="root",
            password="toor",
            database="helpdesk"
        )

        if conexao.is_connected():
            print("Conexão com o banco realizada com sucesso!")

    except Error as erro:
        print(f"Erro ao conectar ao banco: {erro}")

    finally:
        if 'conexao' in locals() and conexao.is_connected():
            conexao.close()
            print("Conexão encerrada.")

conectar_banco()