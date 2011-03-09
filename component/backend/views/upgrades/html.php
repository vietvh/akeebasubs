<?php
/**
 * @package		akeebasubs
 * @copyright	Copyright (c)2010-2011 Nicholas K. Dionysopoulos / AkeebaBackup.com
 * @license		GNU GPLv3 <http://www.gnu.org/licenses/gpl.html> or later
 */

class ComAkeebasubsViewUpgradesHtml extends ComAkeebasubsViewHtml
{
	public function display()
	{	
		KFactory::get('admin::com.akeebasubs.toolbar.upgrades')
                ->setTitle('COM_AKEEBASUBS_UPGRADES_TITLE','akeebasubs') 
				->setIcon('akeebasubs');
		
		return parent::display();
	}
}