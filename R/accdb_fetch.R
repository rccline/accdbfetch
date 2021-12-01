#' Imports tables from MS Access using supplied path to Access DB.
#'
#' @param x path to AccessDB
#' @return tables from Access application.
#' @examples
#' accdb_fetch("/dev/dev-access.accdb")
accdb_fetch <- function(x) {
  dbpath <- x
  ch0<- RODBC::odbcDriverConnect(paste0("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=",dbpath ))

  instr <- RODBC::sqlFetch(ch0, "tblInstrTypes")
  leases <- RODBC::sqlFetch(ch0, "tblLeases") %>%
    dplyr::select(LeaseID, LseSeries, LeaseNo, LeaseNo2, LessorID, LesseeID, InstrTypeID,
           LeaseDate, Royalty, NetAc, GrossAc, RptGrossAc, InkDate, BonusPerAc,
           ExtBonusPerAc, LeaseTerm, LeaseOption, PermitTerm, FiledDate, FileNo, RecVolume, RecPage ) %>%
    dplyr::left_join(instr, by="InstrTypeID") %>%
    dplyr::select(-InstrType, -InstrTypeID)

  tracts <- RODBC::sqlFetch(ch0, "tblLseTracts")
  lessors <- RODBC::sqlFetch(ch0, "tblLessors") %>%
    dplyr::select(LessorID, FirstName, LastName, Address, City, StateOrProvince, STATE, Country,  PostalCode, LessorSSN, LessorTaxID, CompanyName) %>%
    dplyr::rename(County=Country) %>%
    dplyr::mutate(Lessor=paste(FirstName, LastName)) %>%
    dplyr::select(-FirstName, -LastName) %>%
    dplyr::relocate(Lessor, .after=LessorID) %>%
    dplyr::mutate(Lessor=stringr::str_remove(string=Lessor, pattern = "^NA\\s")) %>%
    dplyr::mutate(Lessor=str_remove(string=Lessor, pattern = "^NA$"))


  counties <- RODBC::sqlFetch(ch0, "tblCounties")

  leases <<- leases
  tracts <<- tracts
  lessors <<- lessors
  instr <<- instr
  counties <<- counties
  RODBC::odbcClose(ch0)

}
