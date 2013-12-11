
class Matriz

  def initialize(*col) #col recoge en un array las filas de nuestra matriz.
    
    @matriz = Array.new()
    
    for i in col do
      if i.size == col.size then #nos aseguramos que es una matriz cuadrada.
        @matriz.push(i)
      else
        raise "La matriz debe ser cuadrada"
      end
    end
    
    @dimension = col.size #Guardamos en una variable de instancia la dimension de la matriz.
  
  end
  
  def maximo
   
    if @matriz.is_a? Array then
      
      max = @matriz[0][0]
      
      for i in 0...@dimension
        for j in 0...@dimension
          if @matriz[i][j] > max
            max = @matriz[i][j]
          end
        end
      end
      
      max
      
    elsif @matrix.is_a? Hash then      
      
      max = @matrix[0][0]      
        
      for i in @matrix.keys do
        for j in @matrix[i].keys do
          if @matrix[i][j] > max
            max = @matrix[i][j]
	  end          
	end
      end
      
      max
      
    end
    
  end

  def minimo    
            
    if @matriz.is_a? Array then
      
      min = @matriz[0][0]
      
      for i in 0...@dimension
        for j in 0...@dimension
          if @matriz[i][j] < min
            min = @matriz[i][j]
          end
        end
      end
      
      min
      
    elsif @matrix.is_a? Hash then
    
      min = @matrix[@matrix.keys.first][@matrix[@matrix.keys.first].keys.first]
      
      for i in @matrix.keys do      
	for j in @matrix[i].keys do
	  if @matrix[i][j] < min && @matrix[i][j] != 0 then
            min = @matrix[i][j]
          end
        end
      end
      
      min
      
    end
  
  end

  def [] (*ij) #Recibe un numero de argumentos...
  
  end

  def +(other) #Para la suma de matrices
  
  end

  def -(other) #Para la resta de matrices
  
  end

  def *(other) #Para la multiplicacion de matrices
  
  end
  
end

#################################

class Matrizdensa < Matriz
  
	def initialize(*args) #args recogerá en un array las filas de nuestra matriz.
	    @matriz = Array.new()
	    for i in args do
		if i.size == args.size then #controlamos que es una matriz cuadrada.
		  @matriz.push(i)
		else
		  raise "La matriz debe ser cuadrada"
		end
	    end
	    @dimension = args.size #Guardamos en una variable de instancia la dimension de la matriz.
	end

#RECIBE ARGUNMENTOS
	def [] (*ij)
		return @matriz[*ij] if ij.size == 1  #si el numero de argumentos es solo 1, entonces devolvemos toda la fila indicada.
		    @matriz[ij.first][ij.last]  #si son 2, devuelveme el elemento indicado.

	end


#SUMA
	def +(other)
		matriz3 = Array.new(@dimension) {|i|   #creamos un array de arrays, de dimension @dimension, y cuyo contenido en la posicion[i][j] será el resultado del bloque.
    		Array.new(@dimension) {|j|
      		@matriz[i][j] + other[i][j]
    		}
    	}
	end

#RESTA
	def -(other)
		matriz3 = Array.new(@dimension) {|i|   #creamos un array de arrays, de dimension @dimension, y cuyo contenido en la posicion[i][j] será el resultado del bloque.
    		Array.new(@dimension) {|j|
      		@matriz[i][j] - other[i][j]
    		}
    	}
	end

#MULTIPLICACIÓN
	def *(other)
		matriz3 = Array.new(@dimension) {|i|   #creamos un array de arrays, de dimension @dimension, y cuyo contenido en la posicion[i][j] será el resultado del bloque.
   		Array.new(@dimension) {|j|
   			(0...@dimension).inject(0) do |resultado, k|  #El inject(0) inicializa a 0 el primer argumento (resultado).
          		resultado + @matriz[i][k] * other[k][j]   #Operacion para realizar la multiplicacion de matrices.
        		end
   		}
   	}
	end
	
	def array
		@matriz
	end
	
	def coerce(other)
		[self, other]
	end

#ENCONTRAR     
    def encontrar
      if @matriz.is_a? Array then
      
      encontrar = @matriz[0][0]
      
      	for i in 0...@dimension
        	for j in 0...@dimension
        		if(yield(@matriz[i][j]))
          			return i, j
        		end
      		end
      	end
    	return nil
  	end

end

@Matrizdensa1 = Matrizdensa.new([1,2],[4,5])
(@Matrizdensa1.encontrar {|e| e*e > 6}).should == [1,0])
###########################################
class Vectordisperso
	attr_reader :vector

	def initialize(h = {})
    @vector = Hash.new(0)
    @vector = @vector.merge!(h)
  end

  def to_s
    @vector.to_s
 	end

 	def keys
 		@vector.keys
 	end

  def hash
    @vector
  end

  def +(other)
    @vector.merge!(other.hash){|key, oldval, newval| newval + oldval}
  end

  def -(other)
    @vector.merge!(other.hash){|key, oldval, newval| newval - oldval}
  end

 	def []= (i,v)
 		@vector[i] = v
 	end

	def [](i)
    	@vector[i] 
  	end
end

class Matrizdispersa < Matriz
	
	attr_reader :matrix

	def initialize(h = {})
   	@matrix = Hash.new(0)
    	for k in h.keys do 
      	@matrix[k] = 	if h[k].is_a? Vectordisperso
         						h[k]
            				else 
                     		@matrix[k] = Vectordisperso.new(h[k])
                   	end
    	end
  	end

  	def [](i)
  		@matrix[i]
  	end

    def hash
      @matrix
    end

  	def keys
  		@matrix.keys
  	end

  	def col(j)
    	c = {}
    	for r in @matrix.keys do
      	c[r] = @matrix[r].vector[j] if @matrix[r].vector.keys.include? j
    	end
    	Vectordisperso.new c
  	end

#SUMA
	 def +(other)  
		ms = @matrix.clone
		ms.merge!(other.hash){ |key, oldval, newval| newval + oldval}
   end

#RESTA
   def -(other)  
    ms = @matrix.clone
    ms.merge!(other.hash){ |key, oldval, newval| newval - oldval}
   end

#MULTIPLICACION
   def *(other)  
      ms = Hash.new(0)
      h = Hash.new(0)
      @mul = 0
      for k in @matrix.keys do
        for j in 0..other.hash.keys.count do
          for i in @matrix[k].keys do
              if other.hash[i][j] != 0 then
                @mul += @matrix[k][i] * other.hash[i][j]
              end
          end
          h[j] = @mul unless @mul == 0
          @mul = 0
        end
        ms[k] = h.clone unless h.empty?
        h.clear
      end
      ms2 = Matrizdispersa.new(ms)
   end
end
