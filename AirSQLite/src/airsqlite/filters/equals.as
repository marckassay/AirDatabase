package airsqlite.filters 
{	
	public function equals(value:*):Filter
	{
		return new Filter(' = ', value);
	}
}