# Procedure Checklist

## Stored Procedure `RelatorioBanco`

### Descrição
A stored procedure `RelatorioBanco` é utilizada para monitorar e reportar o status do banco de dados. Ela verifica o espaço disponível nos volumes de armazenamento, o status das bases de dados e a execução de jobs no último ano. Ao final, envia um email com um relatório em formato HTML.

### Detalhes
- **Banco de dados:** Use seu Banco
- **Procedimento:** `dbo.RelatorioBanco`

### Funcionalidade
1. **Inicialização**: Define o HTML base que será utilizado no corpo do email de alerta.
2. **Execução de Verificações**:
   - `Alerta_Espaco_Disco`: Verifica e retorna o espaço livre nos volumes de armazenamento.
   - `USP_StatusBases`: Verifica o status das bases de dados (online/offline).
   - `VerificarJobsFalhos`: Verifica se houve falhas nos jobs executados.
3. **Geração de Relatório**:
   - Se todas as verificações não retornarem erros, o HTML inicial é utilizado.
   - Se erros ou alertas são detectados, eles são incorporados ao relatório HTML, que detalha os problemas encontrados.
4. **Envio de Email**:
   - Utiliza o `sp_send_dbmail` para enviar o email finalizado, incluindo o relatório em formato HTML para o destinatário especificado.

### Estilo
A formatação do email utiliza CSS para estilizar o conteúdo e imagens, garantindo que o relatório seja fácil de ler e visualmente agradável.

### Uso
Execute a stored procedure sem parâmetros necessários diretamente dentro do SQL Server Management Studio ou via script SQL, garantindo que o serviço de email do SQL Server esteja configurado corretamente.


