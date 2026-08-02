extends Node

const SCENE_PATHS: Dictionary = {
	"loading_screen": "uid://qk4cctayieey",
	"house_1": "uid://cjggqamfjfa5j",
	"store_inside": "uid://dm8cnmbmk8prj",
	"house_2": "uid://lwpelvekgdtu",
	"cemetery": "uid://f30c0tc054x8",
	"main_menu": "uid://blqco4uwjomll",
	"store_outside": "",
	"province": "uid://r7lvestv6bu3",
}

const DIALOGUE_PATHS: Dictionary[String, String] = {
	"house_1_start": "uid://dou5hcsecewgy",
	"house_1_door": "uid://k6jkg4fgisgv",
	"house_1_postpickup": "uid://cvfhpohokm35x",
	"joshua": "uid://b5olxe1wu01fs",
	"house_1_bed": "uid://dqnyt0wodjpj3",
	"house_1_bookshelf": "uid://4vncduk2lyp5",
	"house_1_television": "uid://b0v5tgaeb2jtm",
	"house_1_cat": "uid://ceresl40sv6gg",
	"house_1_clothes": "uid://dxktigwqst6ew",
	"house_1_calendar": "uid://527igsw0q8k5",
	"martin": "uid://xhlvhhjl5y1c",
	"queso": "uid://c6n6kavjmw7bm",
	"house_1_console": "uid://bpoj66qvo0htb",
	"realization": "uid://df6f28chmfab0",
	"post_photo": "uid://rpibm06yhuy0",
	"store_inside_start": "uid://b2exfvafx88s",
	"horizontal_storeshelf": "uid://dp4183pbekdyb",
	"vertical_storeshelf": "uid://b45bse7qxbsym",
	"clothes_rack": "uid://bex5og6ofepfx",
	"post_getting": "uid://c3p7kkvewitnf",
	"sdoor": "uid://dh0yrf05ycle5",
	"house_2_start": "uid://btutujhghpbi2",
	"watch": "uid://bkax5a4e5ylkj",
	"jacket": "uid://b4wj5rp36f1h7",
	"medicine": "uid://cweehobuk4o0m",
	"cat_carrier": "uid://kanp1kc1ftow",
	"watch_area": "uid://dhyllxvae5d2g",
	"medical_bills": "uid://cixcpgqmtcvpp",
	"medicine_area": "uid://cxekgjygykbgh",
	"jacket_area": "uid://ca4uyhd4y2rkw",
	"house_2_end": "uid://chy7rpx4jjgpr",
	"carrier_area": "uid://da25aqgsv3h7e",
	"province_start": "uid://bbunr8hahu2lf",
	"first_enter": "uid://chqfl5x4puwcc",
	"round_table": "uid://bpqwda7stwh1y",
	"long_table": "uid://1l48wg4fdw50",
	"refrigerator": "uid://cql6qrdv8phrl",
	"first_exit": "uid://b213drf28k8p5",
	"first_enter_end": "uid://dbugcs8irtu0w",
	"second_enter": "uid://cow545lqq80mv",
	"second_enter_end": "uid://dr2c8vtu51ibe",
	"second_exit": "uid://4rx8vhuxi5vp"
}

const CHARACTER_ICON_PATHS: Dictionary[String, String] = {
	"Max": "uid://b2v2yh8issx3m",
	"Joshua": "uid://ui6si11jgl73",
	"Martin": "uid://bk50cabvxvubg",
	"Driver": "uid://dwtwpw7ysstmw",
	"Tito Elpa": "uid://dti14avwv3s2"
}

const CHARACTER_AUDIO_PATHS: Dictionary[String, String] = {
	"Joshua": "uid://c8opa7cmuxq26",
	"Max": "uid://b3i2l1d6f1ygc",
	"Martin": "uid://bi6ysn3xas8mn",
	"Tito Elpa": "uid://wdv22gym2td2"
}
