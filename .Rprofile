options('width'=100)
options('max.print'=300)

memsize <- function(object=NULL, units='Mb') {
  if (!is.null(object)) {
    print(format(object.size(object), units=units))
  } else {
    object.names = ls(env=globalenv())
    sizes <- lapply(object.names, function(x) object.size(get(x)))
    names(sizes) <- object.names
    sizes <- sizes[order(unlist(sizes), decreasing=T)]
    for (i in 1:length(sizes)) {
      print(names(sizes)[i])
      print(format(sizes[[i]], units=units))
    }
  }
}

# Lines added by the Vim-R-plugin command :RpluginConfig (2014-Apr-27 22:36):
if(interactive()){
  if(nchar(Sys.getenv("DISPLAY")) > 1)
    options(editor = 'gvim -f -c "set ft=r"')
  else
    options(editor = 'vim -c "set ft=r"')
  library(colorout)
  if(Sys.getenv("TERM") != "linux" && Sys.getenv("TERM") != ""){
    # Choose the colors for R output among 256 options.
    # You should run show256Colors() and help(setOutputColors256) to
    # know how to change the colors according to your taste:
    setOutputColors256(verbose = FALSE)
  }
  library(setwidth)
  library(vimcom)
}
