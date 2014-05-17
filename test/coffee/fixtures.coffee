window.fixtures = {}

f = window.fixtures

f.dayViewEvents = [
	{ date: moment().hour(0).minutes(0), data: 'dayView-event1' }
	{ date: moment().add('day', 1), data: 'dayView-event2' }
	{ date: moment().hour(23).minutes(59), data: 'dayView-event3' }
]

f.weekViewEvents = [
	{ date: moment().weekday(0), data: 'weekView-event1' }
	{ date: moment().weekday(3), data: 'weekView-event2' }
	{ date: moment().weekday(6), data: 'weekView-event3' }
	{ date: moment().weekday(7), data: 'weekView-event4' }
	{ date: moment().weekday(-7), data: 'weekView-event5' }
]

f.monthViewEvents = [
	{ date: moment('2013-01-01'), data: 'monthView-event1' }
	{ date: moment('2013-12-28'), data: 'monthView-event2' }
	{ date: moment('2013-12-29'), data: 'monthView-event3' }
	{ date: moment('2014-01-01'), data: 'monthView-event4' }
	{ date: moment('2014-01-15'), data: 'monthView-event5' }
	{ date: moment('2014-01-31'), data: 'monthView-event6' }
	{ date: moment('2014-02-01'), data: 'monthView-event7' }
	{ date: moment('2014-02-02'), data: 'monthView-event8' }
]

f.yearViewEvents = [
	{ date: moment('2013-12-31'), data: 'yearView-event1' }
	{ date: moment('2014-01-01'), data: 'yearView-event2' }
	{ date: moment('2014-12-06'), data: 'yearView-event3' }
	{ date: moment('2014-12-31'), data: 'yearView-event4' }
	{ date: moment('2015-01-01'), data: 'yearView-event5' }
]