source("require.R")

kategloAPI = function(phrase){
  API = "http://kateglo.com/api.php?format=json&phrase="
  req_phrase = fromJSON(paste0(API,phrase))
  Sys.sleep(5)
  get_list = req_phrase[[1]]
  build_dataframe = data_frame(phrase=get_list$phrase,phrase_type=get_list$phrase_type,lex_class=get_list$lex_class,lex_class_name=get_list$lex_class_name,ref_source=get_list$ref_source,ref_source_name=get_list$ref_source_name)
  build_dataframe
}
y = c[!is.na(c$type),]
keterangan_kata = lapply(y$lema,kategloAPI)
keterangan_kata = do.call(rbind,keterangan_kata)
write_csv(keterangan_kata,"keterangan_kata.csv")
