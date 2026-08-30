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
            return conexao

    except Error as erro:
        print(f"Erro ao conectar ao banco: {erro}")

    return None


def listar_chamados(cursor):
    try:
        sql = """
            SELECT Id_Chamado, titulo, status, prioridade, data_abertura
            FROM chamados
        """

        cursor.execute(sql)
        resultados = cursor.fetchall()

        print("\n--- TODOS OS CHAMADOS ---")

        for chamado in resultados:
            print(
                f"ID: {chamado[0]} | "
                f"Título: {chamado[1]} | "
                f"Status: {chamado[2]} | "
                f"Prioridade: {chamado[3]} | "
                f"Abertura: {chamado[4]}"
            )

    except Error as erro:
        print(f"Erro na consulta: {erro}")


def chamados_abertos(cursor):
    try:
        sql = """
            SELECT Id_Chamado, titulo, prioridade, data_abertura
            FROM chamados
            WHERE status = %s
        """

        cursor.execute(sql, ("Aberto",))
        resultados = cursor.fetchall()

        print("\n--- CHAMADOS ABERTOS ---")

        for chamado in resultados:
            print(
                f"ID: {chamado[0]} | "
                f"Título: {chamado[1]} | "
                f"Prioridade: {chamado[2]} | "
                f"Abertura: {chamado[3]}"
            )

    except Error as erro:
        print(f"Erro na consulta: {erro}")


def chamados_com_funcionarios(cursor):
    try:
        sql = """
            SELECT
                c.Id_Chamado,
                c.titulo,
                c.status,
                f.Nome AS funcionario,
                e.tipo AS equipamento
            FROM chamados c
            INNER JOIN Funcionarios f
                ON c.Funcionarios_id_Funcionarios = f.id_Funcionarios
            INNER JOIN equipamentos e
                ON c.equipamentos_id_Equipamento = e.id_Equipamento
        """

        cursor.execute(sql)
        resultados = cursor.fetchall()

        print("\n--- CHAMADOS COM FUNCIONÁRIO E EQUIPAMENTO ---")

        for chamado in resultados:
            print(
                f"ID: {chamado[0]} | "
                f"Título: {chamado[1]} | "
                f"Status: {chamado[2]} | "
                f"Funcionário: {chamado[3]} | "
                f"Equipamento: {chamado[4]}"
            )

    except Error as erro:
        print(f"Erro na consulta: {erro}")


def inserir_chamado(cursor, conexao):
    try:
        titulo = input("Digite o título do chamado: ")
        descricao = input("Digite a descrição: ")
        prioridade = int(input("Digite a prioridade (1 a 4): "))
        funcionario = int(input("Digite o ID do funcionário: "))
        equipamento = int(input("Digite o ID do equipamento: "))

        sql = """
            INSERT INTO chamados
            (
                titulo,
                descricao,
                status,
                prioridade,
                data_abertura,
                data_fechamento,
                Funcionarios_id_Funcionarios,
                equipamentos_id_Equipamento
            )
            VALUES (%s, %s, %s, %s, CURDATE(), NULL, %s, %s)
        """

        valores = (
            titulo,
            descricao,
            "Aberto",
            prioridade,
            funcionario,
            equipamento
        )

        cursor.execute(sql, valores)
        conexao.commit()

        print("Chamado inserido com sucesso!")

    except (Error, ValueError) as erro:
        print(f"Erro ao inserir chamado: {erro}")

def menu():
    conexao = None
    cursor = None

    try:
        conexao = conectar_banco()

        if conexao is None:
            return

        cursor = conexao.cursor()

        while True:
            print("\n--- SISTEMA HELPDESK ---")
            print("1 - Listar todos os chamados")
            print("2 - Listar chamados abertos")
            print("3 - Listar chamados com funcionário e equipamento")
            print("4 - Abrir novo chamado")
            print("0 - Sair")

            opcao = input("Escolha uma opção: ")

            if opcao == "1":
                listar_chamados(cursor)

            elif opcao == "2":
                chamados_abertos(cursor)

            elif opcao == "3":
                chamados_com_funcionarios(cursor)

            elif opcao == "4":
                inserir_chamado(cursor, conexao)

            elif opcao == "0":
                print("Encerrando o sistema...")
                break

            else:
                print("Opção inválida!")

    except Error as erro:
        print(f"Erro no sistema: {erro}")

    finally:
        if cursor is not None:
            cursor.close()

        if conexao is not None and conexao.is_connected():
            conexao.close()
            print("\nConexão encerrada.")


if __name__ == "__main__":
    menu()