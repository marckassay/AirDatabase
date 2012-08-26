package airdatabase.filters.numbers
{
	import airdatabase.filters.Filter;

	public function greaterThan(value:Number):Filter
	{
		return new Filter('greaterThan', ' > ', value);
	}
}