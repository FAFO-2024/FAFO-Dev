-- Add translations by MC
local Translations = {
    headers = {
        ['bsm'] = 'Patron Menüsü - ',
    },
    body = {
        ['manage'] = 'Çalışanları Yönet',
        ['managed'] = 'Çalışanlar Listesini Kontrol Et',
        ['hire'] = 'Çalışan İşe Al',
        ['hired'] = 'Yakındaki Sivilleri İşe Al',
        ['storage'] = 'Depo Erişimi',
        ['storaged'] = 'Depoyu Aç',
        ['outfits'] = 'Kıyafetler',
        ['outfitsd'] = 'Kaydedilmiş Kıyafetleri Görüntüle',
        ['money'] = 'Para Yönetimi',
        ['moneyd'] = 'Şirket Bakiyenizi Kontrol Edin',
        ['mempl'] = 'Çalışanları Yönet - ',
        ['mngpl'] = 'Yönet ',
        ['grade'] = 'Derece: ',
        ['fireemp'] = 'Çalışanı İşten Çıkar',
        ['hireemp'] = 'Çalışanları İşe Al - ',
        ['cid'] = 'Vatandaş Kimlik Numarası: ',
        ['balance'] = 'Bakiye: $',
        ['deposit'] = 'Yatır',
        ['depositd'] = 'Hesaba Para Yatır',
        ['withdraw'] = 'Çek',
        ['withdrawd'] = 'Hesaptan Para Çek',
        ['depositm'] = 'Para Yatır <br> Kullanılabilir Bakiye: $',
        ['withdrawm'] = 'Para Çek <br> Kullanılabilir Bakiye: $',
        ['submit'] = 'Onayla',
        ['amount'] = 'Miktar',
        ['return'] = 'Geri Dön',
        ['exit'] = 'Çıkış',
    },
    drawtext = {
        ['label'] = '[E] İş Yönetimini Aç',
    },
    target = {
        ['label'] = 'Patron Menüsü',
    },
    headersgang = {
        ['bsm'] = 'Çete Yönetimi - ',
    },
    bodygang = {
        ['manage'] = 'Çete Üyelerini Yönet',
        ['managed'] = 'Çete Üyelerini Al veya İşten Çıkar',
        ['hire'] = 'Üye Al',
        ['hired'] = 'Çete Üyelerini İşe Al',
        ['storage'] = 'Depo Erişimi',
        ['storaged'] = 'Çete Stash\'ını Aç',
        ['outfits'] = 'Kıyafetler',
        ['outfitsd'] = 'Kıyafet Değiştir',
        ['money'] = 'Para Yönetimi',
        ['moneyd'] = 'Çete Bakiyenizi Kontrol Edin',
        ['mempl'] = 'Çete Üyelerini Yönet - ',
        ['mngpl'] = 'Yönet ',
        ['grade'] = 'Derece: ',
        ['fireemp'] = 'İşten Çıkar',
        ['hireemp'] = 'Çete Üyelerini İşe Al - ',
        ['cid'] = 'Vatandaş Kimlik Numarası: ',
        ['balance'] = 'Bakiye: $',
        ['deposit'] = 'Yatır',
        ['depositd'] = 'Hesaba Para Yatır',
        ['withdraw'] = 'Çek',
        ['withdrawd'] = 'Hesaptan Para Çek',
        ['depositm'] = 'Para Yatır <br> Kullanılabilir Bakiye: $',
        ['withdrawm'] = 'Para Çek <br> Kullanılabilir Bakiye: $',
        ['submit'] = 'Onayla',
        ['amount'] = 'Miktar',
        ['return'] = 'Geri Dön',
        ['exit'] = 'Çıkış',
    },
    drawtextgang = {
        ['label'] = '[E] Çete Yönetimini Aç',
    },
    targetgang = {
        ['label'] = 'Çete Menüsü',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
