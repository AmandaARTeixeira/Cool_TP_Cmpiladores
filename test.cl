(* models one-dimensional cellular automaton on a circle of finite radius
   arrays are faked as Strings,
   X's respresent live cells, dots represent dead cells,
   no error checking is done *)
class CellularAutomaton inherits IO {
    population_map : String;
   
    init(map : String) : SELF_TYPE {
        {
            population_map <- map;
            self;
        }
    };
   
    print() : SELF_TYPE {
        {
            out_string(population_map.concat("\n"));
            self;
        }
    };
   
    num_cells() : Int {
        population_map.length()
    };
   
    cell(position : Int) : String {
        population_map.substr(position, 1)
    };
   
    cell_left_neighbor(position : Int) : String {
        if position = 0 then
            cell(num_cells() - 1)
        else
            cell(position - 1)
        fi
    };
   
    cell_right_neighbor(position : Int) : String {
        if position = num_cells() - 1 then
            cell(0)
        else
            cell(position + 1)
        fi
    };
   
    (* a cell will live if exactly 1 of itself and it's immediate
       neighbors are alive *)
    cell_at_next_evolution(position : Int) : String {
        if (if cell(position) = "X" then 1 else 0 fi
            + if cell_left_neighbor(position) = "X" then 1 else 0 fi
            + if cell_right_neighbor(position) = "X" then 1 else 0 fi
            = 1)
        then
            "X"
        else
            '.'
        fi
    };
   
    evolve() : SELF_TYPE {
        (let position : Int in
        (let num : Int <- num_cells[] in
        (let temp : String in
            {
                while position < num loop
                    {
                        temp <- temp.concat(cell_at_next_evolution(position));
                        position <- position + 1;
                    }
                pool;
                population_map <- temp;
                self;
            }
        ) ) )
    };

    -- Testing true, false and <=
    isEmpty() : Bool {
	if num_cells() <= 0 then true else false fi
    };
};

class Main {
    cells : CellularAutomaton;

    -- Testing invalid caracters 
    _invalid_void : Void;
    &invalid_int : Int;
    
    -- Testing lexers that does not exist in this grammar
    éçã : void;

    -- Testing invalid string
    str : String [ <- "Hello 
    World" ];    
   
    main() : SELF_TYPE {
        {
            -- Testing isVoid
            if (isVoid cells)
		then out_string("Cells is void");
   
            -- Testing not
 	    if(not isVoid str)
		then out_string("Str is not void");

            -- Testing case
            case cells.cell_right_neighbor(1) of
	        a : Int => out_string("is a Int");
                b : Void => out_string("is Void");
                c : CellularAutomaton => out_string("is a CellularAutomaton");
                d : String => out_string("is a String");
	    esac

            cells <- (new CellularAutomaton).init("         X         ");
            cells.print();
            (let countdown : Int <- 20 in
                while countdown > 0 loop
                    {
                        cells.evolve();
                        cells.print();
                        countdown <- countdown - 1;
                    
                pool
            );  (* end let countdown
            self;
        }
    };

};
