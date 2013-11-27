
include Comparable #librería comparable para desarrollar la práctica

class Fraccion
  attr_accessor :n,:d
  
  def initialize(n,d)
    @n, @d = n, d
  end
  
  #metodo reducir
  def reducir(frac)
    mcd = gcd(frac.n,frac.d)
    fraccion = Fraccion.new((frac.n/mcd),frac.d/mcd)
  end
  
  #metodo num
  def num
    @n
  end
  
  #metodo denom
  def denom
    @d
  end
  
  #metodo string
  def to_s
    "#{@n}/#{@d}"
  end
  
  def gcd(u, v)
    u, v = u.abs, v.abs
    while v != 0
      u, v = v, u % v
    end
    u
  end
  
  #metodo flotante
  def flotante
    @n.to_f/@d.to_f #conversion de tipo a flotante mediante to_f
  end
  
  #metodo == --> para comparar 2 fracciones
  def ==(other)
    if @n==other.n && @d==other.d then
      true
    else
      false
    end
  end
  
  #metodo abs --> Valor absoluto
  def abs
    #Si el numerador es menor que 0, le quitamos lo negativo multiplicando por -1
    if @n < 0 then
      @n = @n * -1
    end
    #Si el denominador es menor que 0, le quitamos lo negativo multiplicando por -1
    if @d < 0 then
      @d = @d * -1
    end
  end
  
  #metodo reciprocal --> invertir numerador por denominador y viceversa
  def reciprocal
    x = @n
    @n = @d
    @d = x
  end
  
  #metodo multiplicacion de dos fracciones
  def *(other)
      @fraccion = Fraccion.new((@n*other.n),@d*other.d)
      reducir(@fraccion)
  end
  
    #metodo de division de dos fracciones
  def /(other)
      @fraccion = Fraccion.new((@n*other.d),@d*other.n)
      reducir(@fraccion)
  end
  
    #metodo de suma de dos fracciones
  def +(other)
      mcm = (@d * other.d)/gcd(@d, other.d)
      @fraccion = Fraccion.new(((mcm/@d*@n) + (mcm/other.d*other.n)),mcm)
      reducir(@fraccion)
  end

    #metodo de resta de dos fracciones
  def -(other)
      mcm = (@d * other.d)/gcd(@d, other.d)
      @fraccion = Fraccion.new(((mcm/@d*@n) - (mcm/other.d*other.n)),mcm)
      reducir(@fraccion)
  end
    
    #método necesario con la librería Comparable
  def <=>(other)
      mcm = (@d * other.d)/gcd(@d, other.d)
      a = (mcm/@d*@n)
      b = (mcm/other.d*other.n)

      if a < b
         -1
      elsif a > b
         1
      else
         0
      end
   end

    #definicion del metodo coerce para racional
  def coerce(other)
      if Integer === other
	  [Fraccion.new(other,1), self]
      end
  end   
   
end
