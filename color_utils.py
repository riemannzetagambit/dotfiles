'''
Utilities I have collected over the years that help make nice plots
'''
import math

from colour import Color

def get_color_gradient_from_range(starting_color, ending_color, num_steps):
    '''
    Return a list of colors that progresses from starting_color to ending_color in num_steps equal hue (?) increments

    :param starting_color: str
        html name or hex value of starting color
    :param ending_color: str
        html name or hex value of ending color
    :param num_steps: int
        number of steps to take from start to end

    :return: list of hex values of colors that increment from starting_color to ending_color
    '''
    color_minus = Color(starting_color)
    color_plus = Color(ending_color)
    return [c.get_hex_l() for c in color_minus.range_to(color_plus, num_steps)]


def get_scale_factor_for_color_property(starting_val, fraction_change_in_property):
    if fraction_change_in_property >= 0:
        scale_factor = 1. + abs(fraction_change_in_property)
        # cannot go above property value of 1, so scale it so it asymptotically approaches 1
        # use property_val = 1 - exp(-x) to model this
        # starting val has x = -log(1-property_val)
        # special case: if property val is 1, can't increase no more
        if starting_val == 1:
            return 1
        else:
            corresponding_x_for_property_val = -1 * math.log(1 - starting_val)
            return 1 - math.exp(-1 * corresponding_x_for_property_val*scale_factor)
    else:
        # for decreases, just divide
        scale_factor = 1./(1. + abs(fraction_change_in_property))
        return starting_val*scale_factor


def get_scaled_color(starting_color, property_to_scale='saturation', fraction_change_in_property=0.05):
    '''
    Given an input color, change the color by scaling one of its properties

    :param color: str
        html or hex color code you want to start with
    :param property_to_scale: str
        'hue', 'saturation', or 'luminance'
    :param fraction_change_in_property: float
        fraction to change `property_to_scale` by from its starting value implied in `color` to the ending color's value

    :return: str
        Hex value of the scaled color property

    '''
    if property_to_scale not in ['saturation', 'hue', 'luminance']:
        raise ValueError(f'property_to_scale must be in [saturation, hue, luminance]. Got "{property_to_scale}" instead.')

    color_start = Color(starting_color)
    if property_to_scale == 'saturation':
        starting_prop = color_start.get_saturation()
        ending_prop = get_scale_factor_for_color_property(starting_prop, fraction_change_in_property)
        color_end = Color(starting_color, saturation=ending_prop)
    elif property_to_scale == 'hue':
        starting_prop = color_start.get_hue()
        ending_prop = get_scale_factor_for_color_property(starting_prop, fraction_change_in_property)
        color_end = Color(starting_color, hue=ending_prop)
    elif property_to_scale == 'luminance':
        starting_prop = color_start.get_luminance()
        ending_prop = get_scale_factor_for_color_property(starting_prop, fraction_change_in_property)
        color_end = Color(starting_color, luminance=ending_prop)
    return color_end.get_hex_l()


def get_color_gradient_by_property(color, num_steps, property_to_scale='saturation', fraction_change_in_property=0.05):
    '''
    Get a gradient of `num_step` colors from the starting `color` to an ending color whose `property_to_scale` (hue,
    saturation, luminance) is scaled by a fractional change `fraction_change_in_property`

    :param color: str
        html or hex color code you want to start with
    :param num_steps: int
        number of steps to take from start to end in making gradient
    :param property_to_scale: str
        'hue', 'saturation', or 'luminance'
    :param fraction_change_in_property: float
        fraction to change `property_to_scale` by from its starting value implied in `color` to the ending color's value

    :return: list
        list of hex-valued color codes that span the desired gradient
    '''
    color_properties = ['saturation', 'hue', 'luminance']
    if fraction_change_in_property > 1 or fraction_change_in_property < -1:
        raise ValueError('fraction_change_in_property must be between -1 and 1')

    if property_to_scale not in color_properties:
        raise ValueError('property_to_scale must be in {}. Got {} instead.'.format(color_properties, property_to_scale))

    color_end = get_scaled_color(color, property_to_scale, fraction_change_in_property)
    return get_color_gradient_from_range(color, color_end, num_steps)
