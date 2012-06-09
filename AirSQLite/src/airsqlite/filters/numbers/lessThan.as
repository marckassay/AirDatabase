package airsqlite.filters.numbers
{
	import airsqlite.filters.Filter;

	public function lessThan(value:Number):Filter
	{
		return new Filter('lessThan', ' < ', value);
	}
}