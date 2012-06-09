package airsqlite.filters.numbers
{
	import airsqlite.filters.Filter;

	public function greaterThan(value:Number):Filter
	{
		return new Filter('greaterThan', ' > ', value);
	}
}