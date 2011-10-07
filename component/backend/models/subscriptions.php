<?php
/**
 * @package AkeebaSubs
 * @copyright Copyright (c)2010-2011 Nicholas K. Dionysopoulos
 * @license GNU General Public License version 3, or later
 */

// Protect from unauthorized access
defined('_JEXEC') or die();

class AkeebasubsModelSubscriptions extends FOFModel
{
	private function getFilterValues()
	{
		return (object)array(
			'search'		=> $this->getState('search',null,'string'),
			'title'			=> $this->getState('title',null,'string'),
			'enabled'		=> $this->getState('enabled',null,'int'),
			'level'			=> $this->getState('level',null,'int'),
			'publish_up'	=> $this->getState('publish_up',null,'string'),
			'publish_down'	=> $this->getState('publish_down',null,'string'),
			'user_id'		=> $this->getState('user_id',null,'int'),
			'paystate'		=> $this->getState('paystate',null,'cmd'),
			'paykey'		=> $this->getState('paykey',null,'string'),
			'since'			=> $this->getState('since',null,'string'),
			'until'			=> $this->getState('until',null,'string'),
			'contact_flag'	=> $this->getState('contact_flag',null,'int'),
			'expires_from'	=> $this->getState('expires_from',null,'string'),
			'expires_to'	=> $this->getState('expires_to',null,'string'),
			'refresh'		=> $this->getState('refresh',null,'int'),
			'groupbydate'	=> $this->getState('groupbydate',null,'int'),
			'moneysum'		=> $this->getState('moneysum',null,'int')
		);
	}
	
	public function buildCountQuery() {
		$db = $this->getDbo();
		$state = $this->getFilterValues();
		
		if($state->refresh == 1) {
			$query = FOFQueryAbstract::getNew($db)
				->select('COUNT(*)')
				->from($db->nameQuote('#__akeebasubs_subscriptions').' AS '.$db->nameQuote('tbl'));

			$this->_buildQueryFrom($query);
			$this->_buildQueryJoins($query);
			$this->_buildQueryWhere($query);
			$this->_buildQueryGroup($query);
			
			// $query retruns X rows, where X is the number of users. We need the count of users, so...
			$query2 =  FOFQueryAbstract::getNew($db)
					->select('COUNT(*)')
					->from( '('.(string)$query.') AS '.$db->nameQuote('tbl'));
			
			return $query2;
		} elseif($state->moneysum == 1) {
			$query = FOFQueryAbstract::getNew($db)
				->select('SUM('.$db->nameQuote('net_amount').') AS '.$db->nameQuote('x'))
				->from($db->nameQuote('#__akeebasubs_subscriptions').' AS '.$db->nameQuote('tbl'));
			
			$this->_buildQueryFrom($query);
			$this->_buildQueryJoins($query);
			$this->_buildQueryWhere($query);
			$this->_buildQueryGroup($query);
			
			return $query;
		} else {
			return parent::buildCountQuery();
		}
	}
	
	protected function _buildQueryJoins(FOFQueryAbstract $query)
	{
		$db = $this->getDbo();
		$state = $this->getFilterValues();
		
		if($state->groupbydate == 1) return;
		
		$query
			->join('INNER', $db->nameQuote('#__akeebasubs_levels').' AS '.$db->nameQuote('l').' ON '.
					$db->nameQuote('l').'.'.$db->nameQuote('akeebasubs_level_id').' = '.
					$db->nameQuote('tbl').'.'.$db->nameQuote('akeebasubs_level_id'))
			->join('INNER', $db->nameQuote('#__users').' AS '.$db->nameQuote('u').' ON '.
					$db->nameQuote('u').'.'.$db->nameQuote('id').' = '.
					$db->nameQuote('tbl').'.'.$db->nameQuote('user_id'))
			->join('LEFT OUTER', $db->nameQuote('#__akeebasubs_users').' AS '.$db->nameQuote('a').' ON '.
					$db->nameQuote('a').'.'.$db->nameQuote('user_id').' = '.
					$db->nameQuote('tbl').'.'.$db->nameQuote('user_id'))
		;
	}
	
	protected function _buildQueryColumns(FOFQueryAbstract $query)
	{
		$db = $this->getDbo();
		$state = $this->getFilterValues();
		
		if($state->refresh == 1) {
			$query->select(array(
				$db->nameQuote('tbl').'.'.$db->nameQuote('akeebasubs_subscription_id'),
				$db->nameQuote('tbl').'.'.$db->nameQuote('user_id')
			));
		} elseif($state->groupbydate == 1) {
			$query->select(array(
				'DATE('.$db->nameQuote('created_on').') AS '.$db->nameQuote('date'),
				'SUM('.$db->nameQuote('net_amount').') AS '.$db->nameQuote('net'),
				'COUNT('.$db->nameQuote('akeebasubs_subscription_id').') AS '.$db->nameQuote('subs')
			));
		} else {
			$query->select(array(
				$db->nameQuote('tbl').'.*',
				$db->nameQuote('l').'.'.$db->nameQuote('title'),
				$db->nameQuote('l').'.'.$db->nameQuote('image'),
				$db->nameQuote('u').'.'.$db->nameQuote('name'),
				$db->nameQuote('u').'.'.$db->nameQuote('username'),
				$db->nameQuote('u').'.'.$db->nameQuote('email'),
				$db->nameQuote('u').'.'.$db->nameQuote('block'),
				$db->nameQuote('a').'.'.$db->nameQuote('isbusiness'),
				$db->nameQuote('a').'.'.$db->nameQuote('businessname'),
				$db->nameQuote('a').'.'.$db->nameQuote('occupation'),
				$db->nameQuote('a').'.'.$db->nameQuote('vatnumber'),
				$db->nameQuote('a').'.'.$db->nameQuote('viesregistered'),
				$db->nameQuote('a').'.'.$db->nameQuote('taxauthority'),
				$db->nameQuote('a').'.'.$db->nameQuote('address1'),
				$db->nameQuote('a').'.'.$db->nameQuote('address2'),
				$db->nameQuote('a').'.'.$db->nameQuote('city'),
				$db->nameQuote('a').'.'.$db->nameQuote('state').' AS '.$db->nameQuote('userstate'),
				$db->nameQuote('a').'.'.$db->nameQuote('zip'),
				$db->nameQuote('a').'.'.$db->nameQuote('country'),
				$db->nameQuote('a').'.'.$db->nameQuote('params').' AS '.$db->nameQuote('userparams'),
				$db->nameQuote('a').'.'.$db->nameQuote('notes').' AS '.$db->nameQuote('usernotes'),
			));
		}
	}
	
	protected function _buildQueryGroup(FOFQueryAbstract $query)
	{
		$db = $this->getDbo();
		$state = $this->getFilterValues();
		
		if($state->refresh == 1) {
			$query->group(array(
				$db->nameQuote('tbl').'.'.$db->nameQuote('user_id')
			));
		} elseif($state->groupbydate == 1) {
			$query->group(array(
				'DATE('.$db->nameQuote('tbl').'.'.$db->nameQuote('created_on').')'
			));
		}
	}
	
	protected function _buildQueryWhere(FOFQueryAbstract $query)
	{
		$db = $this->getDbo();
		$state = $this->getFilterValues();
		
		if($state->refresh == 1) {
			return;
		}
		
		jimport('joomla.utilities.date');
		
		if($state->paystate) {
			$states_temp = explode(',', $state->paystate);
			$states = array();
			foreach($states_temp as $s) {
				$s = strtoupper($s);
				if(!in_array($s, array('C','P','N','X'))) return;
				$states[] = $db->quote($s);
			}
			if(!empty($states)) {
				$query->where(
					$db->nameQuote('tbl').'.'.$db->nameQuote('state').' IN ('.
						implode(',',$states).')'
				);
			}
		}
		
		if($state->paykey) {
			$query->where(
				$db->nameQuote('tbl').'.'.$db->nameQuote('processor_key').' LIKE '.
					$db->quote('%'.$state->paykey.'%')
			);
		}
		
		if(!$state->groupbydate)
		{
			if(is_numeric($state->enabled)) {
				$query->where(
					$db->nameQuote('tbl').'.'.$db->nameQuote('enabled').' = '.
						$db->quote($state->enabled)
				);
			}
	
			if($state->title) {
				$search = '%'.$state->title.'%';
				$query->where(
					$db->nameQuote('tbl').'.'.$db->nameQuote('title').' LIKE '.
						$db->quote($search)
				);
			}
			
			if($state->search)
			{
				$search = '%'.$state->search.'%';
				// @todo Try to use JDatabase quoting functions on this beast without a strong urge to commit suicide
				$query->where(
					'CONCAT(IF(u.name IS NULL,"",u.name),IF(u.username IS NULL,"",u.username),IF(u.email IS NULL, "", u.email),IF(a.businessname IS NULL, "", a.businessname), IF(a.vatnumber IS NULL,"",a.vatnumber)) LIKE '.
						$db->quote($search)
				);
			}
			
			if(is_numeric($state->level)) {
				$query->where(
					$db->nameQuote('tbl').'.'.$db->nameQuote('akeebasubs_level_id').' = '.
						$db->quote($state->level)
				);
			}
			
			if(is_numeric($state->user_id)) {
				$query->where(
					$db->nameQuote('tbl').'.'.$db->nameQuote('user_id').' = '.
						$db->quote($state->user_id)
				);
			}
			
			if(is_numeric($state->contact_flag)) {
				$query->where(
					$db->nameQuote('tbl').'.'.$db->nameQuote('contact_flag').' = '.
						$db->quote($state->contact_flag)
				);
			}
			
			// Filter the dates
			$from = trim($state->publish_up);
			if(empty($from)) {
				$from = '';
			} else {
				$jFrom = new JDate($from);
				$from = $jFrom->toUnix();
				if($from == 0) {
					$from = '';
				} else {
					$from = $jFrom->toMySQL();
				}
			}
			
			$to = trim($state->publish_down);
			if(empty($to) || ($to == '0000-00-00') || ($to == '0000-00-00 00:00:00')) {
				$to = '';
			} else {
				$jTo = new JDate($to);
				$to = $jTo->toUnix();
				if($to == 0) {
					$to = '';
				} else {
					$to = $jTo->toMySQL();
				}
			}
			
			if(!empty($from) && !empty($to)) {
				// Filter from-to dates
				$query->where(
					$db->nameQuote('tbl').'.'.$db->nameQuote('publish_up').' >= '.
						$db->quote($from)
				);
				$query->where(
					$db->nameQuote('tbl').'.'.$db->nameQuote('publish_up').' <= '.
						$db->quote($to)
				);
			} elseif(!empty($from) && empty($to)) {
				// Filter after date
				$query->where(
					$db->nameQuote('tbl').'.'.$db->nameQuote('publish_up').' >= '.
						$db->quote($from)
				);
			} elseif(empty($from) && !empty($to)) {
				// Filter up to a date
				$query->where(
					$db->nameQuote('tbl').'.'.$db->nameQuote('publish_down').' <= '.
						$db->quote($to)
				);
			}
		}
		
		// "Since" queries
		$since = trim($state->since);
		if(empty($since) || ($since == '0000-00-00') || ($since == '0000-00-00 00:00:00')) {
			$since = '';
		} else {
			$jFrom = new JDate($since);
			$since = $jFrom->toUnix();
			if($since == 0) {
				$since = '';
			} else {
				$since = $jFrom->toMySQL();
			}
			// Filter from-to dates
			$query->where(
				$db->nameQuote('tbl').'.'.$db->nameQuote('created_on').' >= '.
					$db->quote($since)
			);
		}
		
		// "Until" queries
		$until = trim($state->until);
		if(empty($until) || ($until == '0000-00-00') || ($until == '0000-00-00 00:00:00')) {
			$until = '';
		} else {
			$jFrom = new JDate($until);
			$until = $jFrom->toUnix();
			if($until == 0) {
				$until = '';
			} else {
				$until = $jFrom->toMySQL();
			}
			$query->where(
				$db->nameQuote('tbl').'.'.$db->nameQuote('created_on').' <= '.
					$db->quote($until)
			);
		}
		
		// Expiration control queries
		jimport('joomla.utilities.date');
		$from = trim($state->expires_from);
		if(empty($from)) {
			$from = '';
		} else {
			$jFrom = new JDate($from);
			$from = $jFrom->toUnix();
			if($from == 0) {
				$from = '';
			} else {
				$from = $jFrom->toMySQL();
			}
		}
		
		$to = trim($state->expires_to);
		if(empty($to) || ($to == '0000-00-00') || ($to == '0000-00-00 00:00:00')) {
			$to = '';
		} else {
			$jTo = new JDate($to);
			$to = $jTo->toUnix();
			if($to == 0) {
				$to = '';
			} else {
				$to = $jTo->toMySQL();
			}
		}
		
		if(!empty($from) && !empty($to)) {
			// Filter from-to dates
			$query->where(
				$db->nameQuote('tbl').'.'.$db->nameQuote('publish_down').' >= '.
					$db->quote($from)
			);
			$query->where(
				$db->nameQuote('tbl').'.'.$db->nameQuote('publish_down').' <= '.
					$db->quote($to)
			);
		} elseif(!empty($from) && empty($to)) {
			// Filter after date
			$query->where(
				$db->nameQuote('tbl').'.'.$db->nameQuote('publish_down').' >= '.
					$db->quote($from)
			);
		} elseif(empty($from) && !empty($to)) {
			// Filter up to a date
			$query->where(
				$db->nameQuote('tbl').'.'.$db->nameQuote('publish_down').' <= '.
					$db->quote($to)
			);
		}
	}
	
	public function buildQuery($overrideLimits = false) {
		$db = $this->getDbo();
		$query = FOFQueryAbstract::getNew($db)
				->from($db->nameQuote('#__akeebasubs_subscriptions').' AS '.$db->nameQuote('tbl'));
		
		$this->_buildQueryColumns($query);
		$this->_buildQueryJoins($query);
		$this->_buildQueryWhere($query);
		$this->_buildQueryGroup($query);
		
		return $query;
	}
	
	public function onProcessList(&$resultArray) {
		// Implement the subscription automatic expiration
		if(empty($resultArray)) return;

		jimport('joomla.utilities.date');
		$jNow = new JDate();
		$uNow = $jNow->toUnix();
		
		$table = $this->getTable($this->table);
		$k = $table->getKeyName();
		
		foreach($resultArray as $index => &$row) {
			$triggered = false;
			
			if(!property_exists($row, 'publish_down')) return;
			
			if($row->publish_down && ($row->publish_down != '0000-00-00 00:00:00')) {
				$jDown = new JDate($row->publish_down);
				if( ($uNow >= $jDown->toUnix()) && $row->enabled ) {
					$row->enabled = 0;
					$triggered = true;
				}
			}
			
			if($triggered) {
				$table->reset();
				$table->load($row->$k);
				$table->save($row);
			}		
		}
	}
}