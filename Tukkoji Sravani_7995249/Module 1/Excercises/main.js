let images = [

"https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=700&h=400&fit=crop",

"https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=700&h=400&fit=crop",

"https://images.unsplash.com/photo-1517649763962-0c623066013b?w=700&h=400&fit=crop",

"https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=700&h=400&fit=crop",

"https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?w=700&h=400&fit=crop",

"https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=700&h=400&fit=crop"

];

let index = 0;

function changeImage(){

    index++;

    if(index >= images.length){

        index = 0;

    }

    document.getElementById("promoImage").src = images[index];

}

setInterval(changeImage, 3000);

function showMessage(){

    document.getElementById("result").innerHTML =
    "Registration Successful!";

}

function validatePhone(){

    let phone =
    document.getElementById("phone").value;

    if(phone.length != 10){

        document.getElementById("phoneMessage").innerHTML =
        "Invalid Phone Number";

    }

    else{

        document.getElementById("phoneMessage").innerHTML =
        "Valid Phone Number";

    }

}

function showFee(fee){

    document.getElementById("eventFee").innerHTML =
    "Event Fee: ₹" + fee;

}

function submitFeedback(){

    alert("Feedback Submitted Successfully!");

}

function enlargeImage(){

    document.getElementById("eventImage").style.width =
    "500px";

    document.getElementById("eventImage").style.height =
    "350px";

}

function countCharacters(){

    let text =
    document.getElementById("feedback").value;

    document.getElementById("charCount").innerHTML =
    text.length;

}

window.onbeforeunload = function(){

    return "Form is not completed. Are you sure you want to leave?";

};

function savePreference(){

    let event =
    document.getElementById("eventType").value;

    localStorage.setItem("preferredEvent", event);

    sessionStorage.setItem("sessionEvent", event);

    document.getElementById("savedPreference").innerHTML =
    "Preference Saved: " + event;

}

window.onload = function(){

    let savedEvent =
    localStorage.getItem("preferredEvent");

    if(savedEvent){

        document.getElementById("eventType").value =
        savedEvent;

    }

};

function clearPreferences(){

    localStorage.clear();

    sessionStorage.clear();

    document.getElementById("savedPreference").innerHTML =
    "Preferences Cleared";

}

function findLocation(){

    navigator.geolocation.getCurrentPosition(

        showPosition,

        showError,

        {
            enableHighAccuracy: true,
            timeout: 5000
        }

    );

}

function showPosition(position){

    document.getElementById("location").innerHTML =

    "Latitude: " + position.coords.latitude +

    "<br>Longitude: " + position.coords.longitude;

}

function showError(error){

    if(error.code == 1){

        alert("Permission Denied");

    }

    else if(error.code == 3){

        alert("Request Timed Out");

    }

}

console.log("Community Event Portal Loaded");