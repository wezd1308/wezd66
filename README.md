#$ExpiringIn = (Get-Date).AddDays(10)

### SCRIPT FECHA VENCIMIENTO PASSWORD AD ####
#AA2000#
#Wintel#

$smtpserver = "smtp"
$from = "from"
$to = "to" 
$subject= "subject"
$body = "INFORMACION DEL VENCIMIENTO DE PASSWORD DE USUARIOS DEL AD"


#Obtiene los usuarios del AD

    Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" |

         Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}} | 


 #Exporta la info a un CSV

         Sort-Object -Descending EXPIRYDATE | export-csv passwords.csv -Encoding UTF8 -NoTypeInformation

  
  #Envio del Mail

    Send-MailMessage -SmtpServer $smtpserver -From $from -to $to -Cc $cc -Subject $subject -Body $body -Attachments .\passwords.csv
