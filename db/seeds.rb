# Create or promote the initial Admin user without resetting an existing password.
admin = User.find_or_initialize_by(email: "admin@email.com")
admin.role = "admin"
if admin.new_record?
  admin.password = "123123"
  admin.password_confirmation = "123123"
end
admin.save!

board_synonyms = {
  1 => ["juara", "ketua", "ikan duyung", "sendiri tiada kawan"],
  2 => ["kasut", "baju", "gunting", "buaya darat", "kopi"],
  3 => ["cincin", "bertunang", "kahwin tiga", "puting susu", "lembab"],
  4 => ["syabuh", "penagih", "kipas angin", "kicap", "donald duck"],
  5 => ["padi", "burung surat", "postman", "cili padi", "pos laju"],
  6 => ["ubat nyamuk", "singa laut", "raja rimba", "passport", "orang asing"],
  7 => ["arnab", "masjid", "playboy", "bintang", "kuih bulan"],
  8 => ["cermin mata", "telefon", "orang buta", "basikal", "rantai babi"],
  9 => ["harimau belang", "tiger balm", "kereta", "bank", "tiger beer"],
  10 => ["sapi", "budak", "susu", "buang anak", "bas"],
  11 => ["arak", "hantu pontianak", "kayu ara", "mayat", "hantu bangkit"],
  12 => ["jam", "masa", "gajah laut", "sarkas", "curi masa"],
  13 => ["penjara", "daun terup", "13 daun", "pencuri kecil", "mickey mouse"],
  14 => ["toto", "kuda laut", "senapang m-14", "pistol", "kuat"],
  15 => ["tentera", "kapal terbang", "kenderaan", "billiard", "bintang filem"],
  16 => ["doktor", "senapang m-16", "gula-gula", "bunga", "suntik"],
  17 => ["panggang", "orang mati", "kuburan", "mayat", "tidak bergerak"],
  18 => ["kerbau", "burung bangau", "rokok", "pelangi", "kapten"],
  19 => ["elektrik", "tv", "radio", "kabel", "computer"],
  20 => ["wang", "kupu-kupu", "lampu", "kunang-kunang", "bendera amerika"],
  21 => ["emas", "rantai leher", "hakim", "rasuah", "casino"],
  22 => ["stc", "kuda laut", "pistol", "kuda kayangan"],
  23 => ["bunga ros", "tahan lasak", "tidak jerak", "duri"],
  24 => ["pisang", "kelapa", "polis", "trafik", "penyapu"],
  25 => ["katak", "perahu layar", "payung", "hujan", "orang laut"],
  26 => ["penyu", "sisir", "petir", "kalung", "kura-kura"],
  27 => ["api", "buddha", "bola api", "perahu naga", "dragon ball"],
  28 => ["polis", "stout", "hot dog"],
  29 => ["sabung", "matahari", "kfc", "ikan laut", "bapa ayam"],
  30 => ["lindung", "meriam", "bom", "bunga api", "peluru berpandu"],
  31 => ["bendera", "ikan sardin", "memancing", "hari merdeka", "ikan piranha"],
  32 => ["orang tua", "tongkat", "intan", "batu permata", "jalan raya"],
  33 => ["ular kecil", "santa claus", "christmas", "pelanduk", "pintar"],
  34 => ["gitar", "artis", "karaoke", "ketam", "undang-undang"],
  35 => ["labah-labah", "pukat", "telur ayam", "spiderman"],
  36 => ["pondan", "haji", "imam", "naik haji", "arab"],
  37 => ["pencuri", "lanun", "superman", "tandas", "orang tua"]
}

board_names = [
  "IKAN BESAR", "BUAYA", "SIPUT", "ITIK", "MERPATI", "SINGA", "ARNAB/BULAN",
  "BABI HIDUP", "HARIMAU", "LEMBU", "SYAITAN", "GAJAH", "TIKUS", "KUDA JANTAN",
  "HARIMAU BINTANG", "PENYENGAT", "BABI MATI", "BANGAU", "KUCING", "RAMA-RAMA",
  "LIPAN", "KUDA BETINA", "PELACUR", "MONYET", "PERAHU", "KURA-KURA", "NAGA",
  "ANJING", "AYAM JANTAN", "BELUT", "IKAN KECIL", "ULAR BESAR", "PAYAU", "UDANG",
  "AYAMBETINA", "KAMBING", "MUSANG"
]

board_names.each_with_index do |name, index|
  board_number = index + 1
  board = Board.find_or_initialize_by(name: name)
  board.active = true if board.new_record?
  board.save!

  board_synonyms.fetch(board_number).each do |word|
    synonym = Synonym.find_or_initialize_by(board: board, word: word)
    synonym.mapping = name
    synonym.save!
  end
end

puts "Seed completed! Admin user ready: admin@email.com"
