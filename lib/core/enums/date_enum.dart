enum DateFormatType {
  short, // e.g., 10/05/2023
  long, // e.g., October 5, 2023
  withTime, // e.g., October 5, 2023 10:30 AM
  iso, // e.g., 2023-10-05T10:30:00Z
  timeOnly, // e.g., 10:30 AM
  dayMonth, // e.g., 05 Oct
  dayMonthYear, // e.g., 05 Oct 2023
  monthDay, // e.g., Oct 05
  monthDayYear, // e.g., Oct 05, 2023
  weekday, // e.g., Thursday
  weekdayLong, // e.g., Thursday, October 5, 2023
  weekdayShort, // e.g., Thu, Oct 5
  yearMonth, // e.g., October 2023
  yearOnly, // e.g., 2023
  timeWithSeconds, // e.g., 10:30:45 AM
  isoDateOnly, // e.g., 2023-10-05 (ISO date without time)
  fullDateTime, // e.g., Thursday, October 5, 2023 10:30:45 AM
}
