# Files to be copied
$Hatch_Pattern_Location = "\\networkshare\Hatch patterns"
$Hatch_Pattern_Files = "acad.pat", "acadiso.pat"

# Get the current user Appdata folder
$appdata = Get-ChildItem -Path Env:\APPDATA
$targetLocation = Join-Path $appdata.Value "Autodesk"
# Get the different Autocad version folders
$Autodesk_folders = Get-ChildItem -Path $targetLocation | Where-Object {$_.Name -match "^AutoCAD 20.."}

foreach ($folder in $Autodesk_folders.Name) {
    Write-Host ( "=====================" )
    Write-Host ( "Autocad: " + $folder )
    Write-Host ( "=====================" )
    $Autocad_folder = Join-Path $targetLocation $folder
    $R_folder = Get-ChildItem -Path $Autocad_folder | Where-Object {$_.Name -match "^R...."}

    # Build the support path location
    $Autocad_folder = Join-Path $targetLocation $folder | Join-Path -ChildPath $R_folder.Name | Join-Path -ChildPath "enu" | Join-Path -ChildPath "Support"
    if (Test-Path -Path $Autocad_folder -PathType Container) { # Test to make sure the support path exists
        Write-Host ( $Autocad_folder )

        foreach ( $File in $Hatch_Pattern_Files ){ # Loop through the files to copy
           $Original = Join-Path $Autocad_folder $File
            $Backup_file = $File +".back"
            $Original_back = Join-Path $Autocad_folder $Backup_file
        
           if (Test-Path -Path $Original -PathType Leaf) { # Backup the original copy
                Write-Host ( "Creating backup: " + $Original_back )
                Copy-Item -Path $Original -Destination $Original_back
            }

            $src = Join-Path $Hatch_Pattern_Location $File
            Write-Host ( $src + " > " + $Autocad_folder )
            Copy-Item -Path $src -Destination $Autocad_folder -force # Overwite the original 
        }
    } else {
        Write-Host ( "Folder is empty: " + $Autocad_folder )
    }
}