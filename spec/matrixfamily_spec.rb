  require './lib/matrixfamily.rb'

describe Fraccion do
  
   before :each do
      @f = Fraccion.new(10,-30)
      @f2 = Fraccion.new(4,-30)
   end
      
      it "Existe un numerador" do
         @f.n.should eq(10)
      end
      
      it "Existe un denominador" do
         @f.d.should eq(-30)
      end
   
      it "Forma reducida" do
	 @f.reducir(@f).should eq(Fraccion.new(1,-3))
      end

      it "Metodo num() para obtener el numerador" do
         @f.num().should eq(10)
      end
      
      it "Metodo denom() para obtener el denominador" do
         @f.denom().should eq(-30)
      end

      it "Mostrar la fraccion de la forma a/b" do
         @f.to_s.should match "10/-30"
      end
      
      it "Mostrar la fraccion en forma flotante" do
         @f.flotante.should eq(-0.3333333333333333)
      end
   
      it "Sumar dos fracciones con resultado en forma reducida" do
         @f.+(@f2).should eq(Fraccion.new(-7,15))
      end
      
      it "Restar dos fracciones con resultado en forma reducida" do
         @f.-(@f2).should eq(Fraccion.new(-1,5))
      end
      
      it "Multiplicar dos fracciones con resultado en forma reducida" do
         @f.*(@f2).should eq(Fraccion.new(2,45))
      end
      
      it "Dividir dos fracciones con resultado en forma reducida" do
         @f./(@f2).should eq(Fraccion.new(-5,-2))
      end
      
      it "Valor absoluto de una fraccion" do
         @f.abs
         @f.num.should eq(10)
         @f.denom.should eq(30)
      end

      it "Reciproco de una fraccion" do
         @f.reciprocal
         @f.num.should eq(-30)
         @f.denom.should eq(10)
      end
      
      it "Compara si dos fracciones son iguales" do
         @f3 = Fraccion.new(10,-30)
         @f4 = Fraccion.new(4,22)
         @f.==(@f3).should be true
         @f.==(@f4).should be false
      end
      
      it "Compara si una fraccion es menor que otra" do
         @f3 = Fraccion.new(-10,20)
         @f4 = Fraccion.new(3,2)
         @f.<(@f3).should be true
         @f.<(@f4).should be false
      end
      
      it "Compara si una fraccion es menor o igual que otra" do
         @f3 = Fraccion.new(10,-30)
         @f4 = Fraccion.new(1,2)
         @f.<=(@f3).should be true
         @f.<=(@f4).should be false
      end
      
      it "Compara si una fraccion es mayor o igual que otra" do
         @f3 = Fraccion.new(10,-30)
         @f4 = Fraccion.new(-10,40)
         @f.>=(@f3).should be true
         @f.>=(@f4).should be true
      end
end

describe Matrizdensa do

        before :each do
                @Matrizdensa = Matrizdensa.new([1,2,3],[4,5,6],[7,8,9])
                @Matrizdensa1 = Matrizdensa.new([1,2],[4,5])
                @Matrizdensa2 = Matrizdensa.new([3,2,1],[6,5,4],[9,8,7])
                @Matrizdensa5 = Matrizdensa.new([Fraccion.new(2,5),Fraccion.new(2,3)],[Fraccion.new(3,4),Fraccion.new(5,9)])
                @Matrizdensa6 = Matrizdensa.new([Fraccion.new(1,5),Fraccion.new(5,3)],[Fraccion.new(5,4),Fraccion.new(6,9)])
        end
	
        it "Comprueba que la Matrizdensa es cuadrada" do
                expect { Matrizdensa.new([2,3,3],[3,4],[1,2,3]) }.to raise_error
                expect { Matrizdensa.new([2,3,3],[1,2,3]) }.to raise_error
        end

        it "Accede a los elementos de la Matrizdensa" do
                @Matrizdensa[0][0].should eq(1)
                @Matrizdensa[0][1].should eq(2)
                @Matrizdensa[0][2].should eq(3)
                @Matrizdensa[1][0].should eq(4)
                @Matrizdensa[1][1].should eq(5)
                @Matrizdensa[1][2].should eq(6)
                @Matrizdensa[2][0].should eq(7)
                @Matrizdensa[2][1].should eq(8)
                @Matrizdensa[2][2].should eq(9)
                @Matrizdensa5[0][0].should eq(Fraccion.new(2,5))
        end

        it "Suma dos matrices" do
                @Matrizdensa3 = @Matrizdensa + @Matrizdensa2
                @Matrizdensa7 = @Matrizdensa5 + @Matrizdensa6
                @Matrizdensa8 = @Matrizdensa1 + @Matrizdensa6
                @Matrizdensa3[0][0].should eq(4)
                @Matrizdensa3[0][1].should eq(4)
                @Matrizdensa3[0][2].should eq(4)
                @Matrizdensa3[1][0].should eq(10)
                @Matrizdensa3[1][1].should eq(10)
                @Matrizdensa3[1][2].should eq(10)
                @Matrizdensa3[2][0].should eq(16)
                @Matrizdensa3[2][1].should eq(16)
                @Matrizdensa3[2][2].should eq(16)
                @Matrizdensa7[0][0].should eq(Fraccion.new(3,5))
                @Matrizdensa8[0][0].should eq(Fraccion.new(6,5))
        end

        it "Halla el maximo de una matriz" do
                max = @Matrizdensa.maximo
                max.should eq(9)
        end

        it "Halla el minimo de una matriz" do
                min = @Matrizdensa.minimo
                min.should eq(1)
        end

        it "Resta dos matrices" do
                @Matrizdensa3 = @Matrizdensa - @Matrizdensa2
                @Matrizdensa7 = @Matrizdensa5 - @Matrizdensa6
                @Matrizdensa8 = @Matrizdensa1 - @Matrizdensa6
                @Matrizdensa3[0][0].should eq(-2)
                @Matrizdensa3[0][1].should eq(0)
                @Matrizdensa3[0][2].should eq(2)
                @Matrizdensa3[1][0].should eq(-2)
                @Matrizdensa3[1][1].should eq(0)
                @Matrizdensa3[1][2].should eq(2)
                @Matrizdensa3[2][0].should eq(-2)
                @Matrizdensa3[2][1].should eq(0)
                @Matrizdensa3[2][2].should eq(2)
                @Matrizdensa7[0][0].should_not eq(Fraccion.new(3,5))  #####################
                @Matrizdensa8[0][0].should_not eq(Fraccion.new(-5,5)) #####################
        end

        it "Multiplica dos matrices" do
                @Matrizdensa3 = @Matrizdensa * @Matrizdensa2
                @Matrizdensa7 = @Matrizdensa5 * @Matrizdensa6
                @Matrizdensa8 = @Matrizdensa1 * @Matrizdensa6
                @Matrizdensa3[0][0].should eq(42)
                @Matrizdensa3[0][1].should eq(36)
                @Matrizdensa3[0][2].should eq(30)
                @Matrizdensa3[1][0].should eq(96)
                @Matrizdensa3[1][1].should eq(81)
                @Matrizdensa3[1][2].should eq(66)
                @Matrizdensa3[2][0].should eq(150)
                @Matrizdensa3[2][1].should eq(126)
                @Matrizdensa3[2][2].should eq(102)
                @Matrizdensa7[0][0].should_not eq(Fraccion.new(12,10)) ####################
                @Matrizdensa8[0][0].should_not eq(Fraccion.new(30,10)) ####################
        end
        
        it "Pasar pos en la que un elemento al cuadrado es mayor que 6" do
      			((@Matrizdensa1.encontrar {|e| e*e > 6}).should == [1,0])
    	end
end

describe Matrizdispersa do

        before :each do
                @Matrizdispersa = Matrizdispersa.new(100 => {100 => 1, 500 => 200}, 20000 => { 1000 => 3, 9000 => 200})
                @Matrizdispersa2 = Matrizdispersa.new(100 => {100 => 2, 50 => 3}, 200 => { 30 => 10})
                @Matrizfrac = Matrizdispersa.new(0 => {0 => Fraccion.new(1,3), 1 => Fraccion.new(1,3)}, 2 => {0 => Fraccion.new(1,3), 2 => Fraccion.new(1,3)})
                @Matrizfrac2 = Matrizdispersa.new(0 => {0 => Fraccion.new(6,3), 1 => Fraccion.new(5,3)}, 2 => {0 => Fraccion.new(5,3), 2 => Fraccion.new(2,3)})
        end
	
        it "Accede a los elementos de la matriz" do
                @Matrizdispersa[0][0].should eq(0)
                @Matrizdispersa[100][100].should eq(1)
                @Matrizdispersa[100][500].should eq(200)
        end

        it "Suma una matriz dispersa con otra" do
                @Matrizdispersa3 = @Matrizdispersa + @Matrizdispersa2
                @Matrizdispersa3[100][100].should eq(3)
                @Matrizdispersa3[100][50].should eq(3)
                @Matrizdispersa3[100][500].should eq(200)
                @Matrizdispersa3[200][30].should eq(10)
                @Matrizdispersa3[20000][1000].should eq(3)
                @Matrizdispersa3[20000][9000].should eq(200)
                @Matrizdispersa4 = @Matrizfrac + @Matrizfrac2
                @Matrizdispersa4[0][0].should eq(Fraccion.new(7,3))
                @Matrizdispersa4[0][1].should eq(Fraccion.new(2,1))
                @Matrizdispersa4[2][0].should eq(Fraccion.new(2,1))
        end

        it "Resta una matriz dispersa con otra" do
                @Matrizdispersa3 = @Matrizdispersa - @Matrizdispersa2
                @Matrizdispersa3[100][100].should eq(-1)
                @Matrizdispersa3[100][50].should eq(3)
                @Matrizdispersa3[100][500].should eq(200)
                @Matrizdispersa3[200][30].should eq(10)
                @Matrizdispersa3[20000][1000].should eq(3)
                @Matrizdispersa3[20000][9000].should eq(200)
                @Matrizdispersa4 = @Matrizfrac - @Matrizfrac2
                @Matrizdispersa4[0][0].should eq(Fraccion.new(-5,3))
                @Matrizdispersa4[0][1].should eq(Fraccion.new(-4,3))
                @Matrizdispersa4[2][0].should eq(Fraccion.new(-4,3))
        end

        it "Multiplica una matriz dispersa con otra" do
                @a = Matrizdispersa.new(0 => {0 => 7, 1 => 1}, 2 => {0 => 2, 2 => 3})
                @b = Matrizdispersa.new(0 => {0 => 2, 1 => 3}, 1 => {0 => 2}, 2 => {2 => 1})
                @c = Matrizdispersa.new(0 => {0 => 1}, 1 => {1 => 2}, 2 => {2 => 2})
                @d = Matrizdispersa.new(0 => {0 => 3, 2 => 2}, 2 => {0 => 1, 2 => 2})
                @e = Matrizdispersa.new(0 => {1 => 2, 2 => 1}, 1 => {1 => 3}, 3 => {0 => 1})
                @f = Matrizdispersa.new(1 => {1 => 1, 2 => 3}, 2 => {0 => 2})
                @Matrizdispersa3 = @a * @b
                @Matrizdispersa3[0][0].should eq(16)
                @Matrizdispersa3[0][1].should eq(21)
                @Matrizdispersa3[2][0].should eq(4)
                @Matrizdispersa3[2][1].should eq(6)
                @Matrizdispersa3[2][2].should eq(3)
                @Matrizdispersa4 = @c * @d
                @Matrizdispersa4[0][0].should eq(3)
                @Matrizdispersa4[0][2].should eq(2)
                @Matrizdispersa4[2][0].should eq(2)
                @Matrizdispersa4[2][2].should eq(4)
                @Matrizdispersa4 = @e * @f
                @Matrizdispersa4[0][0].should eq(2)
                @Matrizdispersa4[0][1].should eq(2)
                @Matrizdispersa4[0][2].should eq(6)
                @Matrizdispersa4[1][1].should eq(3)
                @Matrizdispersa4[1][2].should eq(9)
        end
	
        it "Opera una matriz dispersa con una densa" do
                @densa = Matrizdensa.new([1,2,4],[4,3,2],[7,6,4])
                @dispersa = Matrizdispersa.new(1 => {1 => 1, 2 => 3}, 2 => {0 => 2})
                @suma = @densa + @dispersa
                @suma[0][0].should eq(1)
                @suma[0][1].should eq(2)
                @suma[0][2].should eq(4)
                @suma[1][0].should eq(4)
                @suma[1][1].should eq(4)
                @suma[1][2].should eq(5)
                @suma[2][0].should eq(9)
                @suma[2][1].should eq(6)
                @suma[2][2].should eq(4)

                @mult = @densa * @dispersa
                @mult[0][0].should eq(8)
                @mult[0][1].should eq(2)
                @mult[0][2].should eq(6)
                @mult[1][0].should eq(4)
                @mult[1][1].should eq(3)
                @mult[1][2].should eq(9)
                @mult[2][0].should eq(8)
                @mult[2][1].should eq(6)
                @mult[2][2].should eq(18)
        end

        it "Halla el maximo de una matriz" do
                max = @Matrizdispersa.maximo
                max.should eq(200)
        end

        it "Halla el minimo de una matriz" do
                min = @Matrizdispersa.minimo
                min.should eq(1)
        end

end