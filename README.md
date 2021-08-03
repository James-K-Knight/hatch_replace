# hatch_replace
A simple powershell script to Batch replace hatch pattern files in all the Autocad installs on the system.

This is useful for overiding the default hatch patterns to prevent clashes of existing hatches.

![image](https://user-images.githubusercontent.com/57244441/127946582-064f0837-b140-4ea9-85c6-83dde455b959.png)


# Usage

Edit the `$Hatch_Pattern_Location` and `$Hatch_Pattern_Files` variables to match your files and locations

```
# Files to be copied
$Hatch_Pattern_Location = "\\networkshare\Hatch patterns"
$Hatch_Pattern_Files = "acad.pat", "acadiso.pat"
```

# Restoring

The original hatch files are copied in place with `.back` appended
