let tabIndex = 0;
let progressIndex = [0,0];


$(function(){
    document.getElementById("fNameInput").addEventListener("input", function(){
        let firstName = this.value.replace(/[^A-Za-z]/g, "");
        if(firstName != undefined && firstName != "" && firstName.length >= 2 && firstName.length <= 15) {
            progressIndex[0] = 1;
            if(progressIndex[0] == 1 && progressIndex[1] == 1) {
                document.getElementById("finishedIcon").style.display = "block";
                document.getElementById("notFinishedIcon").style.display = "none";
            }
        } else {
            document.getElementById("finishedIcon").style.display = "none";
            document.getElementById("notFinishedIcon").style.display = "block";
        }
        document.getElementById("fNameInput").value = firstName;
    });

    document.getElementById("lNameInput").addEventListener("input", function(){
        let lastName = this.value.replace(/[^A-Za-z]/g, "");
        if(lastName != undefined && lastName != "" && lastName.length >= 2 && lastName.length <= 15) {
            progressIndex[1] = 1;
            if(progressIndex[0] == 1 && progressIndex[1] == 1) {
                document.getElementById("finishedIcon").style.display = "block";
                document.getElementById("notFinishedIcon").style.display = "none";
            }
        } else {
            document.getElementById("finishedIcon").style.display = "none";
            document.getElementById("notFinishedIcon").style.display = "block";
        }
        document.getElementById("lNameInput").value = lastName;
    });

    document.getElementById("progressTab").addEventListener("click", function(){
        if(progressIndex[0] == 1 && progressIndex[1] == 1) {
            let fName = document.getElementById("fNameInput").value;
            let lName = document.getElementById("lNameInput").value;
            let age = document.getElementById("ageRange").value;
            let gender = document.getElementById("genderMale").checked ? "male" : "female";
            $.post('http://swoopspawn/closewithsuccess', JSON.stringify({
                "firstName": fName,
                "lastName": lName,
                "gender": gender,
                "age": age,
                "mother1": document.getElementById("mother1Value").value,
                "mother2": document.getElementById("mother2Value").value,
                "father1": document.getElementById("father1Value").value,
                "father2": document.getElementById("father2Value").value,
                "shapeMix": (parseFloat(document.getElementById("shapeMixValue").value/10).toFixed(2)),
                "skinMix": (parseFloat(document.getElementById("skinMixValue").value/10).toFixed(2))
            }));
        }
    });

    document.getElementById("nextTab").addEventListener("click", function(){
        switch(tabIndex) {
            case 0:
                document.getElementById("identityContent").style.display = "none";
                document.getElementById("characterContent").style.display = "block";
                
                document.getElementById("tabIcon1").style.display = "none";
                document.getElementById("tabIcon2").style.display = "block";

                document.getElementById("tabHeaderIcon1").style.display = "none";
                document.getElementById("tabHeaderIcon2").style.display = "block";

                tabIndex = 1;
                break;
            case 1:
                document.getElementById("characterContent").style.display = "none";
                document.getElementById("identityContent").style.display = "block";
                    
                document.getElementById("tabIcon1").style.display = "block";
                document.getElementById("tabIcon2").style.display = "none";

                document.getElementById("tabHeaderIcon1").style.display = "block";
                document.getElementById("tabHeaderIcon2").style.display = "none";

                tabIndex = 0;
                break;
            default:
                break;
        }
    });
});