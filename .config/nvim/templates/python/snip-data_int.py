from numbers import Real


{{_filter_:data_compare}}
class Data:

    def __init__(self, {{_input_:name_of_value:value}}: Real):
        self.{{_input_:name_of_value:value}} = {{_input_:name_of_value:value}}

    def __eq__(self, other):
        assert isinstance(other, Data)
        return self.{{_input_:name_of_value:value}} == other.{{_input_:name_of_value:value}}
    
    def __eq__(self, other):
        assert isinstance(other, Data)
        return self.{{_input_:name_of_value:value}} == other.{{_input_:name_of_value:value}}
    
    def __lt__(self, other):
        assert isinstance(other, Data)
        return self.{{_input_:name_of_value:value}} < {{_input_:name_of_value:value}}
    
    def __ne__(self, other):
        return not self.__eq__(other)
    
    def __le__(self, other):
        return self.__lt__(other) or self.__eq__(other)
    
    def __gt__(self, other):
        return not self.__le__(other)
    
    def __ge__(self, other):
        return not self.__lt__(other)
