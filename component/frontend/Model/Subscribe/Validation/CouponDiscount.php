<?php
/**
 * @package   AkeebaSubs
 * @copyright Copyright (c)2010-2015 Nicholas K. Dionysopoulos
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Subscriptions\Site\Model\Subscribe\Validation;

defined('_JEXEC') or die;

use Akeeba\Subscriptions\Site\Model\Coupons;

class CouponDiscount extends Base
{
	/**
	 * Get the discount from applying a coupon
	 *
	 * @return  float
	 */
	protected function getValidationResult()
	{
		// Get the coupon validation results
		$couponValidation = $this->factory->getValidator('Coupon')->execute();

		// No valid coupon, no coupon discount
		if (!$couponValidation['valid'])
		{
			return 0.0;
		}

		/** @var Coupons $coupon */
		$coupon = $couponValidation['coupon'];

		// Double check we really do have a coupon
		if (!is_object($coupon))
		{
			return 0.0;
		}

		// Get the base price of the subscription
		$basePrice = $this->factory->getValidator('BasePrice')->execute();

		// Initialise the coupon discount value
		$couponDiscount = 0.0;

		// Get the actual coupon discount amount
		switch ($coupon->type)
		{
			case 'value':
				$couponDiscount = (float)$coupon->value;

				if ($couponDiscount > $basePrice)
				{
					$couponDiscount = $basePrice;
				}

				if ($couponDiscount <= 0.001)
				{
					$couponDiscount = 0.0;
				}
				break;

			case 'percent':
				$percent = (float)$coupon->value / 100.0;

				if ($percent <= 0.001)
				{
					$percent = 0.0;
				}

				if ($percent > 0.999)
				{
					$percent = 1.0;
				}

				$couponDiscount = $percent * $basePrice;
				break;
		}

		return $couponDiscount;
	}

}