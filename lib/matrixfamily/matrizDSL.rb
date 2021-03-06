class MatrizDSL

  attr_accessor :name, :questions

  def initialize(operacion = "", &block)
    @operacion = operacion
    @operandos = []
    if block_given?
      if block.arity == 1
        yield self
      else
        instance_eval &block
      end
    end
  end

  def operand(mat = [])
    a = mat[0]
    b = mat[1]
    c = mat[2]
    m = Matrizdensa.new(a,b,c)
    @operandos << m
  end

  def to_s
    for i in @dimension
      puts @matriz[i]
    end
  end

  def operar

    if @operacion == "suma" then
      a = @operandos[0] + @operandos[1]
    elsif @operacion == "resta" then
      a = @operandos[0] - @operandos[1]
    elsif @operacion == "multiplicacion" then
      a = @operandos[0] * @operandos[1]
    end
  end
end