// ------------------------------------------------------------
// MultipleActive
// ------------------------------------------------------------

#module

#uselib "user32.dll"
#func FindWindow "FindWindowA" sptr, sptr

// IsMultipleActive ...Cheack multiple activation.
#defcfunc IsMultipleActive str _title
  return (0 != FindWindow(0, _title))

#global
