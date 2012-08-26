package airdatabase.filters.numbers
{
	import airdatabase.filters.Filter;

	public function lessThan(value:Number):Filter
	{
		return new Filter('lessThan', ' < ', value);
	}
}