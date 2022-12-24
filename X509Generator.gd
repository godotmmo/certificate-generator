extends Node

var X509_cert_filename = "X509_Certificate.crt" # use the name of the application.crt
var X509_key_filename = "X509_Key.key" # use the name of the application key
@onready var X509_cert_path = "user://Certificate/" + X509_cert_filename
@onready var X509_key_path = "user://Certificate/" + X509_key_filename

var CN = "MultiplayerTutorial"
var O = "GodotMMO"
var C = "US"
var not_before = "20221223000000"
var not_after = "20231223000000" 

func _ready():
	if not DirAccess.dir_exists_absolute("user://Certificate"):
		DirAccess.make_dir_absolute("user://Certificate")
	
	CreateX509Cert()
	print("Certificate Created")


func CreateX509Cert():
	var CNOC = "CN=" + CN + ",O=" + O + ",C=" + C
	var crypto = Crypto.new()
	var crypto_key = crypto.generate_rsa(4096)
	var X509_cert = crypto.generate_self_signed_certificate(crypto_key, CNOC, not_before, not_after)
	X509_cert.save(X509_cert_path)
	crypto_key.save(X509_key_path)
