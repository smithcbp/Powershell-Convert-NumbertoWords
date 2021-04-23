Function Convert-NumbertoWords {
    Param($number)

    $ErrorActionPreference = "SilentlyContinue"
    $numbercommas = [string]::Format('{0:N0}',$number)
    $numbergroups = $numbercommas -split ','
    
    Function Convert-3DigitNumberToWords {
        Param([int]$number)
        $wordarray = @{
            1 = 'one'
            2 = 'two'
            3 = 'three'
            4 = 'four'
            5 = 'five'
            6 = 'six'
            7 = 'seven'
            8 = 'eight'
            9 = 'nine'
            10 = 'ten'
            11 = 'eleven'
            12 = 'twelve'
            13 = 'thirteen'
            14 = 'fourteen'
            15 = 'fifteen'
            16 = 'sixteen'
            17 = 'seventeen'
            18 = 'eighteen'
            19 = 'nineteen'
            20 = 'twenty'
            30 = 'thirty'
            40 = 'forty'
            50 = 'fifty'
            60 = 'sixty'
            70 = 'seventy'
            80 = 'eighty'
            90 = 'ninety'
        }
        
        if ($number -le 19){
            $word = $wordarray.$($number)
            }
            
        $Ones = $number.ToString().ToCharArray()[-1].ToString().ToInt32($null)
        $Tens = $number.ToString().ToCharArray()[-2].ToString().ToInt32($null)
        $Hundreds = $number.ToString().ToCharArray()[-3].ToString().ToInt32($null)
        $OnesTens = (-join ($number.ToString().ToCharArray()[-2..-1])).ToInt32($null)

        if ($Hundreds -ge 1) {
            $HundredsWord = "$($wordarray.($hundreds)) hundred"
            }
        if ($OnesTens -le 19) {
            $OneTensWord = $wordarray.($OnesTens)
            }
        if ($Tens -ge 2 ) {
            $Tensword = $wordarray.($Tens * 10)
            $Onesword = $wordarray.($Ones) 
            if ($onestens % 10 -eq 0){$OneTensWord = $Tensword}
            else {$OneTensWord = $Tensword + '-' + $Onesword}
            }

        $finalwordarray = @($hundredsword,$OneTensword)
        $finalwordarray = $finalwordarray | where-Object {$_}
        $finalwordarray -join " "
        }
        
    $groupwordarray = foreach ($numbergroup in $numbergroups) {
        Convert-3DigitNumberToWords -number $numbergroup
        }

    $thouwordhash = @{
            1 = ''
            2 = 'thousand'
            3 = 'million'
            4 = 'billion'
            5 = 'trillion'
            6 = 'quadrillion'
            7 = 'quintillion'
            8 = 'sextillion'
            9 = 'septillion'
            10 = 'octillion'           
        }

    [array]::reverse($groupwordarray)

    $i = 0
    $modifiedgroups = foreach($group in $groupwordarray){
        $i++
        if ($group){ Write-Output "$group $($thouwordhash.$i)" }
    }
    
    [array]::reverse($modifiedgroups)
    
    $numbercommas
    $modifiedgroups -join ' '
}