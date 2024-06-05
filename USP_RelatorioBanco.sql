USE [ESeuBanco]
GO


CREATE   PROCEDURE [dbo].[RelatorioBanco]
AS
BEGIN



DECLARE @HtmlContent NVARCHAR(MAX) = '';
DECLARE @HtmlContent2 NVARCHAR (MAX) = '';
DECLARE @HtmlContent3 NVARCHAR(MAX) = '';
DECLARE @FinalHtml NVARCHAR(MAX) = '';
DECLARE @Mensagem NVARCHAR(MAX);



SET @Mensagem = '<html>
					<head>
						<style>
							.online { color: green}
						</style>
					</head>
						<body>
							<h1>Verificação Banco de Dados:</h1>
							<br></br>
							<p>Todos os volumes de armazenamento estão operando com espaço adequado, todas as nossas bases de dados estão <span class="online">online</span> e não foi registrado erro em nenhum job.</p>
							<br></br>
							<img src="F:\CIS\Logotipos\TCE-RJ\STI_CIS.png" width="40%">
						</body>
				</html>'
    EXEC [dbo].[Alerta_Espaco_Disco]
        @email = '',
        @htmlOutput = @HtmlContent OUTPUT;

    EXEC [dbo].[USP_StatusBases]
        @HtmlOutput2 = @HtmlContent2 OUTPUT;

    EXEC [dbo].[VerificarJobsFalhos]
        @HtmlOutput3 = @HtmlContent3 OUTPUT;



IF @HtmlContent = '' AND @HtmlContent2 = '' AND @HtmlContent3 = ''
	BEGIN
		SET @FinalHtml = @Mensagem
END
ELSE 
	BEGIN
		SET @HtmlContent = CASE WHEN @HtmlContent = '' THEN 'Nenhum volume está com Epaço Livre abaixo do limite.' ELSE @HtmlContent END
		SET @HtmlContent2 = CASE WHEN @HtmlContent2 = '' THEN 'Nenhuma base encontra-se <span style="color:red">OFFLINE</span>' ELSE @HtmlContent2 END
		SET @HtmlContent3 = CASE WHEN @HtmlContent3 = '' THEN 'Nenhum Job com erro' ELSE @HtmlContent3 END

		SET @FinalHtml ='<html>
        <head>
            <style>
                .container {
                    width: 100%;
                    border-collapse: collapse;
                    border: none; 
                }
                .column {
                    width: 50%;
                    padding: 10px;
                    vertical-align: top;
                    border: none; 
                }
                .center-content {
                    text-align: center;
                }
            </style>
        </head>
        <body> 
            <div class="center-content">
                ' + @HtmlContent + N'
            </div>
			<br></br>
            <table class="container">
                <tr>
                    <td class="column">
                        ' + @HtmlContent2 + N'
                    </td>
                    <td class="column">
                        ' + @HtmlContent3 + N'
                    </td>
                </tr>
            </table>
            <br></br>
            <img src="F:\CIS\Logotipos\TCE-RJ\STI_CIS.png" width="40%">
        </body>
        </html>'

	END

			EXEC msdb.dbo.sp_send_dbmail
            @profile_name = '',
            @recipients = '',
            @subject = '',
            @body = @FinalHtml,
            @body_format = 'HTML'

END
GO


