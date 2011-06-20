package  
{
	/**
	 * ...
	 * @author Yuri Ketov
	 */
	public class LINQ
	{
		protected var items :Array;
		
		public function LINQ( dataItems :Array ) // TODO:? Array -> Iterable or Object 
		{
			items = dataItems;
		}
		
		/*
		 * @param clause:T->Int->Bool
		 */
		public function where( clause :Function ):LINQ 
		{
			var i :int = 0;
			var newList :Array = [];
			for each (var item :* in items)  // FIXME: заменить это все на операции с массивами ?
			{
				if ( clause(item,i++) ) 
					newList.push(item);
			}
			return new LINQ(newList);
		}
		
		/*
		 * @param clause:T->F
		 */
		public function select (clause :Function):LINQ 
		{
			var newList :Array = [];
			
			for each (var item :* in items) 
			{
				var newItem :* = clause(item);
				if (newItem != null)
					newList.push (newItem);
			}
			return new LINQ(newList);
		}
		
		/**
		 * эта похоже для выборки массивов и собирания их в один
		 * clause:T->Array<F>
		 */
		public function selectMany ( clause: Function ) :LINQ
		{
			var r :Array = new Array(), a :*;
			for each (var item :* in items) {
				a = clause(item);
				r = r.concat(a);
			}
			return new LINQ(r);
		}
		
		public function orderBy  (clause:Function) :OrderedLINQ
		{
			var tempArray :Array = items.slice();
			function sortFn (a :*, b :*):int {
				var x :* = clause(a);
				var y :* = clause(b);
				return (x > y)? 1 : (x < y)? - 1 : 0 ;;
			}
			tempArray.sort(sortFn);

			return new OrderedLINQ(tempArray, [sortFn]);
		}
		
		/**
		 * поиск элемента по индексу
		 */
		public function elementAt (i:int) :* 
		{
			var count :int = 0;
			for each (var item:* in items) {   // TODO : items[i] ?
				if (count++ == i) return item; 
			}
			return null;
		}
		
		/**
		 * ?clause:T->Int->Bool
		 */
		public function count( clause :Function = null ):int 
		{
			if (clause == null) {
				return items.length;
			} else {
				return this.where(clause).items.length;
			}
		}
		
		/**
		 * ?clause:T->Int->Bool
		 */
		public function first( clause:Function = null ): * {
			if (clause != null) {
				return this.where(clause).first();
			} else {
				return items[0];
			}
		}
		
		/**
		 * ?clause:T->Int->Bool
		 */
		public function last(clause:Function = null):* 
		{
			if (clause != null) {
				return this.where(clause).last();
			} else {
				if (items.length > 0) {
					return items.pop();
				} else {
					return null;
				}
			}
		}
		
	}

}