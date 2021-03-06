## I needed this script for use with pwnagotchi
## Download the hashcat-utitls here https://github.com/hashcat/hashcat-utils/releases
## Change these three variables to match your folders and files
 
$pcapfolder = "C:\Users\User\Documents\handshakes"
$hccapxfolder = "C:\Users\User\Documents\handshakesconverted"
$cap2location = "C:\path_to_cap2hccapx\hashcat-utils-1.9\hashcat-utils-1.9\bin\cap2hccapx.exe"



$files = Get-ChildItem -name $pcapfolder

foreach ($file in $files){
$file2 = $file
& $cap2location "$pcapfolder\$file" "$hccapxfolder\$file2.hccapx"
}

Write-Host "Done."

## comment out this part if you don't want the files combined into one.
Try {
Write-Host "Attempting to combine all valid hashes into one large Hashcat hccapx file"`n
Get-Content -encoding Byte -path $hccapxfolder\*.hccapx | Set-Content -Encoding Byte $hccapxfolder\multi-$(get-date -f yyyy-MM-dd).hccapx
Write-Host "Merged all valid (p)cap files into $hccapxfolder\multi-$(get-date -f yyyy-MM-dd).hccapx"
Write-Host "multi-$(get-date -f yyyy-MM-dd).hccapx can now be used with hashcat:"
Write-Host ".\hashcat64.exe -m 2500 $hccapxfolder\multi-$(get-date -f yyyy-MM-dd).hccapx BIGWORDLISTHERE.txt"
}
Catch {

   Write-Host $_.Exception.Message -ForegroundColor Red
   Write-Host "This could mean that a multi-$(get-date -f yyyy-MM-dd).hccapx file has already been created today." -ForegroundColor Red
   Write-Host "Please delete or move the old file and then run this script again" -ForegroundColor Red
   Write-Host "Or you could modify the script to use a different method when combining hccapx files" -ForegroundColor Red
}
