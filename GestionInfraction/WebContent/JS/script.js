// Fonction globale

// Vérifier si nom valide
function checkName(name) {
    var regexName = new RegExp("^[a-zA-z -]{1,100}$");
    return regexName.test(name);
};

// Vérifier si email valide
function checkEmail(email) {
    var regexEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return regexEmail.test(email);
};

// Vérifier si mot de passe valide ==> Une autre façon de faire regexp
function checkPassword(password){
    var regexPassword = new RegExp("^(?=.*[0-9])" // Doit contenir un chiffre
    + "(?=.*[a-z])(?=.*[A-Z])" // Doit contenir majuscule et minuscule
    + "(?=\\S+$).{4,20}$") // Pas d'espace permis + longueur mdp 4 - 20);
    return regexPassword.test(password);
};

// Vérifier champ vide
function checkIsEmpty(string){
	if(string == ""){
		return true;
	}
	
	return false;
};

// Vérifier nombre négatif
function checkIsNegative(number){
	if(number <=0){
		return true;
	}
	
	return false;
};
