package  
{
	public class OrderedLINQ extends LINQ
	{
		private var sortFns :Array;

		public function OrderedLINQ (dataItems :Array, sortFns :Array ) {
			super(dataItems);
			this.sortFns = sortFns;
		}
		
		/**
		 * TODO: дописать
		 * clause:T->T2
		 */
		public function thenBy( clause :Function ):OrderedLINQ 
		{
			var tempArray :Array = items.slice(); // copy
			var _sortFns :Array = sortFns.slice();
			_sortFns.push(function(a:*, b:*):int {
				var x:* = clause(a);
				var y:* = clause(b);
				return (x > y)? 1 : (x < y)? - 1 : 0 ;
			});

			tempArray.sort(function(a:*, b:*):int {
				var r: int = 0;
				for each (var sortFn :Function in _sortFns){
					r = sortFn(a,b);
					if (r != 0) break;
				}
				
				return r;
			});

			return new OrderedLINQ(tempArray, _sortFns);
		}

		public function thenByDescending  (clause: Function):OrderedLINQ {
			var tempArray:Array = items.slice();
			var _sortFns = sortFns.slice();
			_sortFns.push(function(a, b):int {
				var x = clause(b);
				var y = clause(a);
				return (x > y)? 1 : (x < y)? - 1 : 0 ;;
			});

			tempArray.sort(function(a, b):int {
				var r :int = 0;
				for each (var sortFn :Function in _sortFns){
					r = sortFn(a,b);
					if (r != 0) break;
				}
				
				return r;
			});

			return new OrderedLINQ(tempArray, _sortFns);
		}
	}

}