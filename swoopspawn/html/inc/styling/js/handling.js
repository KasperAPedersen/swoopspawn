let sliders = [
    ["Mors ansigt", "mother1Value", "mother1View", 0, 45, 0, "face"],
    ["Fars ansigt", "father1Value", "father1View", 0, 45, 0, "face"],
    ["Mors hudfarve", "mother2Value", "mother2View", 0, 45, 0, "face"],
    ["Fars hudfarve", "father2Value", "father2View", 0, 45, 0, "face"],
    ["Ansigt", "shapeMixValue", "shapeMixView", 0, 10, 5, "face"],
    ["Hudfarve", "skinMixValue", "skinMixView", 0, 10, 5, "face"]
]

$(function(){
    for(let i = 0; i < sliders.length; i++) {
        let div = document.createElement("div");
        div.classList = "w3-container";
        div.innerHTML = `<input type="range" min="${sliders[i][3]}" max="${sliders[i][4]}" value="${sliders[i][5]}" class="slider" id="${sliders[i][1]}"><p>${sliders[i][0]}: <span id="${sliders[i][2]}">0</span></p>`;
        document.getElementById("characterContentDump").appendChild(div);

        let tmp1 = sliders[i][1], tmp2 = sliders[i][2], tmp3 = sliders[i][6];
        document.getElementById(tmp1).oninput = function(){
            document.getElementById(tmp2).innerHTML = this.value;
            sendUpdateToCharacter(tmp3);
        };
    }

    window.addEventListener('message', function(event){
        let data = event.data;
        if(data.enabled) {
            document.getElementById("swoop").style.display = "block";

        } else {
            document.getElementById("swoop").style.display = "none";
        }
    });

    function sendUpdateToCharacter(zoom){
        $.post('http://swoopspawn/updateCharacter', JSON.stringify({
            "zoom": zoom,
            "gender": document.getElementById("genderMale").checked ? "mp_m_freemode_01" : "mp_f_freemode_01",

            "mother1": document.getElementById("mother1Value").value,
            "mother2": document.getElementById("mother2Value").value,
            "father1": document.getElementById("father1Value").value,
            "father2": document.getElementById("father2Value").value,
            "shapeMix": (parseFloat(document.getElementById("shapeMixValue").value/10).toFixed(2)),
            "skinMix": (parseFloat(document.getElementById("skinMixValue").value/10).toFixed(2))
        }));
    };

    document.body.onkeyup = function(event){
        if (event.keyCode == 27) {
            $.post('http://swoopspawn/closeswoopspawn', JSON.stringify({}));
        }
    };

    document.getElementById("genderMale").addEventListener("change", function(){
        sendUpdateToCharacter("face");
    });

    document.getElementById("genderFemale").addEventListener("change", function(){
        sendUpdateToCharacter("face");
    });

    document.getElementById("ageRange").oninput = function(){
        document.getElementById("ageView").innerHTML = this.value;
        sendUpdateToCharacter("face");
    };
});
