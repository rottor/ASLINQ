package  {
	import org.flexunit.Assert;

	public class TestLINQ {

		[Test]
		public function testWhere() :void 
		{
			var r :LINQ;		
			r = new LINQ(people)  .where( function(p:*, i:int):Boolean { return p.firstName == "Chris"; });
			Assert.assertEquals(2, r.count());

			r = new LINQ(people) .where( function(p:*, i:int):Boolean { return p.firstName == "Chris" && i == 0; } );
			Assert.assertEquals(1, r.count());
		}
		
		[Test]
		public function testSelect() :void 
		{
			var r :LINQ = new LINQ(people) .select( function(p:*):* { return p.firstName; } );
			
			Assert.assertEquals(10, r.count() );
		    Assert.assertTrue(r.first() is String);
		}
		
		[Test]
		public function testSelectMany() :void 
		{
			var r :LINQ = new LINQ(people)
							  .selectMany(function(p:*):* { return p.bookIds; } );
			Assert.assertEquals(30, r.count());
			Assert.assertTrue(r.first() is int );
		}
		
		[Test]
		public function testOrderBy():void 
		{
			var r :LINQ = new LINQ(people)
					.orderBy(function(p:*):* { return p.firstName.charCodeAt(0); });
			Assert.assertEquals(10, r.count());
			Assert.assertEquals("Bernard", r.first().firstName);
			Assert.assertEquals("Steve",   r.last().firstName);
		}
		
		// -----------------------------------------------------------------------------------
		
		static public var people :Array = 
		[
			{ id: 1, firstName: "Chris", lastName: "Pearson", bookIds: [1001, 1002, 1003] },
			{ id: 2, firstName: "Kate", lastName: "Johnson", bookIds: [2001, 2002, 2003] },
			{ id: 3, firstName: "Josh", lastName: "Sutherland", bookIds: [3001, 3002, 3003] },
			{ id: 4, firstName: "John", lastName: "Ronald", bookIds: [4001, 4002, 4003] },
			{ id: 5, firstName: "Steve", lastName: "Pinkerton", bookIds: [1001, 1002, 1003] },
			{ id: 6, firstName: "Katie", lastName: "Zimmerman", bookIds: [2001, 2002, 2003] },
			{ id: 7, firstName: "Dirk", lastName: "Anderson", bookIds: [3001, 3002, 3003] },
			{ id: 8, firstName: "Chris", lastName: "Stevenson", bookIds: [4001, 4002, 4003] },
			{ id: 9, firstName: "Bernard", lastName: "Sutherland", bookIds: [1001, 2002, 3003] },
			{ id: 10, firstName: "Kate", lastName: "Pinkerton", bookIds: [4001, 3002, 2003] }
		];
	}
}
