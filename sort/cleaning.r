#cek tipe data
str(sample)
lapply(run_test, str)
lapply(run_train, str)

#cek missing value dan hapus missing value
cek_sample <- colSums(is.na(sample))
cek_test <- lapply(run_test, function(df) print(colSums(is.na(df))))
cek_train <- lapply(run_train, function(df) print(colSums(is.na(df))))

new_sample <- na.omit(sample)
new_test <- lapply(run_test, na.omit)
new_train <- lapply(run_train, na.omit)

#cek duplikat
duplikat_sample <- duplicated(sample)
duplikat_test <- lapply(run_test, duplicated)
duplikat_train <- lapply(run_train, duplicated)

double_sample <- sum(duplikat_sample)
double_test <- lapply(duplikat_test, sum)
double_train <- lapply(duplikat_train, sum)

#standarisasi format data
clean_test <- lapply(new_test, function(df) {
    df$Comment <- trimws(df$Comment)
    df
})
clean_train <- lapply(new_train, function(df) {
    df$Comment <- trimws(df$Comment)
    df
})

#hapus data NA pada detected_test dan detected_train
new_detected_test <- lapply(detected_test, function(df) {
    df <- df[!is.na(df$Language), ]
    df
})
new_detected_train <- lapply(detected_train, function(df) {
    df <- df[!is.na(df$Language), ]
    df
})
