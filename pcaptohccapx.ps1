## I needed this script for use with pwnagotchi
$pcapfolder = "C:\Users\User\Documents\hands"
$hccapxfolder = "C:\Users\User\Documents\handsconverted"
$cap2location = "C:\pathtocap2hccapx\hashcat-utils-1.9\hashcat-utils-1.9\bin\cap2hccapx.exe"

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
}
Catch {

   Write-Host $_.Exception.Message -ForegroundColor Red
   Write-Host "This could mean that a multi-$(get-date -f yyyy-MM-dd).hccapx file has already been created today." -ForegroundColor Red -BackgroundColor Yellow
   Write-Host "Please delete or move the old file and then run this script again" -ForegroundColor Red
   Write-Host "Or you could modify the script to use a different method when combining hccapx files" -ForegroundColor Red -BackgroundColor Yellow
}