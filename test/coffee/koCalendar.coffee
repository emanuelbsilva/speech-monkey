expect = chai.expect
fixtures = window.fixtures

describe 'koCalendar', ->

	beforeEach ->
		koCalendar.events []
		koCalendar.currentDate moment()

	describe 'dayView', ->
		it 'should have only one isNow true', ->
			times = 0
			_.each koCalendar.dayView(), (hour) ->
				if hour.isNow then times++

			expect(times).to.equal 1

		it 'should only show events in currentDate day', ->
			numEvents = 0

			koCalendar.events fixtures.dayViewEvents
			expect(koCalendar.events()).to.have.length 3

			_.each koCalendar.dayView(), (hour) -> numEvents += hour.events.length

			expect(numEvents).to.equal 2

	describe 'weekView', ->
		it 'should return an array with length 7', ->
			expect(koCalendar.weekView()).to.have.length 7

		it 'should have isToday true on one entry if currentDate is in present week', ->
			numIsToday = 0

			_.each koCalendar.weekView(), (day) -> 
				numIsToday++ if day.isToday

			expect(numIsToday).to.equal 1

		it 'should have isToday false on all entries if currentDate is no in present week', ->
			koCalendar.currentDate moment().add('days', 15)
			numIsToday = 0

			_.each koCalendar.weekView(), (day) -> 
				numIsToday++ if !day.isToday

			expect(numIsToday).to.equal 7			

		it 'should only have events in currentDate week', ->
			numEvents = 0

			koCalendar.events fixtures.weekViewEvents
			expect(koCalendar.events()).to.have.length 5

			_.each koCalendar.weekView(), (day) ->
				_.each day.hours, (hour) ->
					numEvents += hour.events.length

			expect(numEvents).to.equal 3

	describe 'monthView', ->

		eachDayOfMonth = (cb) ->
			_.each koCalendar.monthView(), (week) ->
				_.each week.days, (day) -> 
					cb day

		it 'should return an array with length equal to number of month weeks', ->
			#5 weeks
			koCalendar.currentDate moment '2014-03-15'
			expect(koCalendar.monthView()).to.have.length 6
			
			#3 weeks
			koCalendar.currentDate moment '2014-02-15'
			expect(koCalendar.monthView()).to.have.length 5

		it 'should show past month days in first week if month does not start in first day of week', ->
			koCalendar.currentDate moment '2014-01-15'

			month = koCalendar.monthView()
			_.each [0..2], -> expect(month[0].days[1].date.year()).to.equal 2013

		it 'should show next month days in last week if month does not end in last day of week', ->
			koCalendar.currentDate moment '2014-01-15'

			month = koCalendar.monthView()
			expect(month[4].days[6].date.month()).to.equal 1
			
		it 'should have isToday true if day equals to todays month', ->
			numIsToday = 0

			eachDayOfMonth (day) ->
				if day.isToday
					numIsToday++
					expect(moment().isSame day.date, 'day').to.equal true

			expect(numIsToday).to.equal 1

		it 'should only have events in currentDate month (and past month and next month days)', ->
			numEvents = 0

			koCalendar.currentDate moment '2014-01-15'
			koCalendar.events fixtures.monthViewEvents

			expect(koCalendar.events()).to.have.length 8

			eachDayOfMonth (day) ->	
				numEvents += day.events.length

			expect(numEvents).to.equal 5

	describe 'yearView', ->

		it 'should have length 12', ->
			expect(koCalendar.yearView()).to.have.length 12

		it 'should have isThisMonth true on todays month', ->
			numTodaysMonth = 0

			_.each koCalendar.yearView(), (month) ->
				if month.isThisMonth
					numTodaysMonth++
					expect(moment().isSame month.date, 'month')

			expect(numTodaysMonth).to.equal 1

		it 'should not have isTodayMonth true if not current year', ->
			numTodaysMonth = 0
			koCalendar.currentDate moment '2013'

			_.each koCalendar.yearView(), (month) ->
				if month.isThisMonth then numTodaysMonth++

			expect(numTodaysMonth).to.equal 0

		it 'should only have events from currentDate year', ->
			koCalendar.events fixtures.yearViewEvents
			tests = [
				{ year: '2013', expected: 1 }
				{ year: '2014', expected: 3 }
				{ year: '2015', expected: 1 }
			]

			_.map tests, (test) ->
				numEvents = 0
				koCalendar.currentDate moment test.year

				_.each koCalendar.yearView(), (month) -> numEvents += month.events.length
				
				expect(numEvents).to.equal test.expected

	test = (direction, view) ->
		koCalendar.currentView view
		if direction > 0 then koCalendar.nextDate() else koCalendar.previousDate()
		expect(moment().add(view, direction).isSame koCalendar.currentDate(), view).to.equal true

	describe 'nextDate', ->
		it 'should increment a day when currentView is day', ->
			test 1, 'day'
		it 'should increment a week when currentView is week', ->
			test 1, 'week'
		it 'should increment a month when currentView is month', ->
			test 1, 'month'
		it 'should increment a year when currentView is year', ->
			test 1, 'year'

	describe 'previousDate', ->
		it 'should decrement a day when currentView is day', ->
			test -1, 'day'
		it 'should decrement a week when currentView is week', ->
			test -1, 'week'
		it 'should decrement a month when currentView is month', ->
			test -1, 'month'
		it 'should decrement a year when currentView is year', ->
			test -1, 'year'

	describe 'displayDate', ->
		it 'should return day when currentView is dayView', ->
			koCalendar.currentView 'day'
			expect(koCalendar.displayDate()).to.equal moment().format 'dddd D MMMM YYYY'

		it 'should return week when currentView is weekView', ->
			koCalendar.currentView 'week'
			expect(koCalendar.displayDate()).to.equal moment().format 'W - YYYY'

		it 'should return month when currentView is monthView', ->
			koCalendar.currentView 'month'
			expect(koCalendar.displayDate()).to.equal moment().format 'MMMM YYYY'

		it 'should return year when currentView is yearView', ->
			koCalendar.currentView 'year'
			expect(koCalendar.displayDate()).to.equal moment().format 'YYYY'