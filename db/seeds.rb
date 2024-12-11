skills = [
  # 戦闘技能
  { name: "回避", calculation: "DEX*2", genre: "戦闘技能" },
  { name: "キック", default_value: 25, genre: "戦闘技能" },
  { name: "組み付き", default_value: 25, genre: "戦闘技能" },
  { name: "こぶし（パンチ）", default_value: 25, genre: "戦闘技能" },
  { name: "頭突き", default_value: 10, genre: "戦闘技能" },
  { name: "投擲", default_value: 25, genre: "戦闘技能" },
  { name: "マーシャルアーツ", default_value: 1, genre: "戦闘技能" },
  { name: "拳銃", default_value: 20, genre: "戦闘技能" },
  { name: "サブマシンガン", default_value: 15, genre: "戦闘技能" },
  { name: "ショットガン", default_value: 30, genre: "戦闘技能" },
  { name: "マシンガン", default_value: 15, genre: "戦闘技能" },
  { name: "ライフル", default_value: 25, genre: "戦闘技能" },

  # 探索技能
  { name: "応急手当", default_value: 30, genre: "探索技能" },
  { name: "鍵開け", default_value: 1, genre: "探索技能" },
  { name: "隠す", default_value: 15, genre: "探索技能" },
  { name: "隠れる", default_value: 10, genre: "探索技能" },
  { name: "聞き耳", default_value: 25, genre: "探索技能" },
  { name: "忍び歩き", default_value: 10, genre: "探索技能" },
  { name: "写真術", default_value: 10, genre: "探索技能" },
  { name: "精神分析", default_value: 1, genre: "探索技能" },
  { name: "追跡", default_value: 10, genre: "探索技能" },
  { name: "登攀", default_value: 40, genre: "探索技能" },
  { name: "図書館", default_value: 25, genre: "探索技能" },
  { name: "目星", default_value: 25, genre: "探索技能" },

  # 行動技能
  { name: "運転", default_value: 20, genre: "行動技能" },
  { name: "機械修理", default_value: 20, genre: "行動技能" },
  { name: "重機械操作", default_value: 1, genre: "行動技能" },
  { name: "乗馬", default_value: 5, genre: "行動技能" },
  { name: "水泳", default_value: 25, genre: "行動技能" },
  { name: "製作", default_value: 5, genre: "行動技能" },
  { name: "操縦", default_value: 1, genre: "行動技能" },
  { name: "跳躍", default_value: 25, genre: "行動技能" },
  { name: "電気修理", default_value: 10, genre: "行動技能" },
  { name: "ナビゲート", default_value: 10, genre: "行動技能" },
  { name: "変装", default_value: 1, genre: "行動技能" },

  # 交渉技能
  { name: "言いくるめ", default_value: 5, genre: "交渉技能" },
  { name: "信用", default_value: 15, genre: "交渉技能" },
  { name: "説得", default_value: 15, genre: "交渉技能" },
  { name: "値切り", default_value: 5, genre: "交渉技能" },
  { name: "母国語", calculation: "EDU*5", genre: "交渉技能" },

  # 知識技能
  { name: "医学", default_value: 5, genre: "知識技能" },
  { name: "オカルト", default_value: 5, genre: "知識技能" },
  { name: "化学", default_value: 1, genre: "知識技能" },
  { name: "クトゥルフ神話", default_value: 0, genre: "知識技能" },
  { name: "芸術", default_value: 5, genre: "知識技能" },
  { name: "経理", default_value: 10, genre: "知識技能" },
  { name: "考古学", default_value: 1, genre: "知識技能" },
  { name: "コンピューター", default_value: 1, genre: "知識技能" },
  { name: "心理学", default_value: 5, genre: "知識技能" },
  { name: "人類学", default_value: 1, genre: "知識技能" },
  { name: "生物学", default_value: 1, genre: "知識技能" },
  { name: "地質学", default_value: 1, genre: "知識技能" },
  { name: "電子工学", default_value: 1, genre: "知識技能" },
  { name: "天文学", default_value: 1, genre: "知識技能" },
  { name: "博物学", default_value: 10, genre: "知識技能" },
  { name: "物理学", default_value: 1, genre: "知識技能" },
  { name: "法律", default_value: 5, genre: "知識技能" },
  { name: "薬学", default_value: 1, genre: "知識技能" },
  { name: "歴史", default_value: 20, genre: "知識技能" }
]

skills.each do |skill|
  Skill.find_or_create_by(name: skill[:name]) do |s|
    s.default_value = skill[:default_value] if skill[:default_value]
    s.calculation = skill[:calculation] || '' # 計算式を空文字で初期化
    s.genre = skill[:genre]
  end
end