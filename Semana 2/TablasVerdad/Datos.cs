using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;

namespace TablasVerdad
{

    class Datos
    {
        static void Main(string[] args)
        {

            try
            {
                Datos d = new Datos();
                d.Leer();
            }
            catch (Exception e)
            {
                Console.Write(e.Message);
            }
        }
        public void Leer()
        {
            Console.Write("Expresion: ");
            string expresion = Console.ReadLine();
            string infija = expresion.ToLower();

            var (n, listWithoutDuplicates) = Variables(infija);
            Caracteres(infija);
            Expresion(infija);
            Parentesis(infija);
            string postfija = Postfija(infija);

            Console.WriteLine("\nTabla de verdad: ");
            Evaluar(postfija, listWithoutDuplicates, n);
        }

        public (int, List<char>) Variables(string infija)
        {
            List<char> variables = new List<char>();
            for (int i = 0; i < infija.Length; i++)
            {
                if (Char.IsLetter(infija[i]))
                    variables.Add(infija[i]);
            }

            List<char> listWithoutDuplicates = variables.Distinct().ToList();

            if (listWithoutDuplicates.Count <= 4 && listWithoutDuplicates.Count > 0)
                return (listWithoutDuplicates.Count, listWithoutDuplicates);
            else
                throw new Exception();
        }

        public void Caracteres(string infija)
        {
            for (int i = 0; i < infija.Length; i++)
            {
                if (!(infija[i] == '=' || infija[i] == '*' || infija[i] == '+' || infija[i] == '-' || infija[i] == '>'
                    || infija[i] == '(' || infija[i] == ')' || Char.IsLetter(infija[i])))
                {
                    throw new Exception();
                }
            }
        }

        public void Parentesis(string infija)
        {
            int cont = 0;
            for (int i = 0; i < infija.Length; i++)
            {
                if (infija[i] == '(')
                    cont++;
                if (infija[i] == ')')
                    cont--;
            }
            if (cont != 0)
                throw new Exception();
        }

        public void Expresion(string infija)
        {
            for (int i = 0; i < infija.Length; i++)
            {
                if (infija[i] == '-')
                {
                    if (i + 1 < infija.Length)
                    {
                        if (!Char.IsLetter(infija[i + 1]) && infija[i + 1] != '(')
                            throw new Exception();
                    }
                    else
                        throw new Exception();
                }
                else if (infija[i] == '=' || infija[i] == '*' || infija[i] == '+' || infija[i] == '>' || infija[i] == '(')
                {
                    if (i + 1 < infija.Length)
                    {
                        if (!Char.IsLetter(infija[i + 1]) && infija[i + 1] != '(' && infija[i + 1] != '-')
                            throw new Exception();
                    }
                    else
                        throw new Exception();
                }
                else if (infija[i] == ')' || Char.IsLetter(infija[i]))
                {
                    if (i + 1 < infija.Length)
                    {
                        if (infija[i + 1] != ')' && infija[i + 1] != '*' && infija[i + 1] != '=' && infija[i + 1] != '+' && infija[i + 1] != '>')
                            throw new Exception();
                    }
                }
            }
        }

        public string Postfija(string infija)
        {
            string postfija = "";
            Stack<char> pila = new Stack<char>();

            for (int i = 0; i < infija.Length; i++)
            {
                if (Char.IsLetter(infija[i]))
                    postfija += infija[i];
                else
                {
                    // Entra si la pila esta vacia
                    if (pila.Count() == 0)
                        pila.Push(infija[i]);
                    else
                    {
                        // Sale si hay un ) hasta un (
                        if (infija[i] == ')')
                        {
                            do
                            {
                                postfija += pila.Pop();
                            } while (pila.Pop() != '(');
                        }
                        else
                            //Entra si PE > PS
                            postfija = Prioridades(infija[i], pila, postfija);
                    }
                }
            }
            // Al finalizar vaciamos la pila
            while (pila.Count() != 0)
                postfija += pila.Pop();

            return postfija;
        }
        public string Prioridades(char simb, Stack<char> pila, string postfija)
        {
            char[] simbolo = { '(', '-', '*', '+', '>', '=', ')' };
            int pe = 0, ps = 0;
            int[] PE = { 7, 6, 4, 3, 2, 1, -1 };
            int[] PS = { 0, 5, 4, 3, 2, 1, -1 };

            char simb2 = pila.Pop();

            for (int i = 0; i < simbolo.Length; i++)
            {
                if (simbolo[i] == simb)
                    pe = PE[i];
                if (simbolo[i] == simb2)
                    ps = PS[i];
            }

            if (pe > ps)
            {
                pila.Push(simb2);
                pila.Push(simb);
            }
            else
            {
                postfija += simb2;
                pila.Push(simb);
            }
            return postfija;
        }

        public void Evaluar(string postfija, List<char> variables, int n)
        {
            List<char> tablas = new List<char>();
            List<char> resultados = new List<char>();
            int combinaciones = Convert.ToInt32(Math.Pow(2, n));
            tablas = Tablas(combinaciones, n);
            resultados = Evaluar(tablas, postfija, n, combinaciones, variables);
            Imprimir(variables, tablas, combinaciones, resultados);
        }

        public List<char> Tablas(int combinaciones, int n)
        {
            int aux = combinaciones / 2, cont = 0, cont2 = 0;
            List<char> tablas = new List<char>();
            for (int i = 0; i < n; i++)
            {
                cont = cont2 = 0;
                for (int j = 0; j < combinaciones; j++)
                {
                    if (cont < aux)
                    {
                        tablas.Add('V');
                        cont++;
                    }
                    else
                    {
                        tablas.Add('F');
                        cont2++;
                        if (cont2 == aux)
                        {
                            cont = cont2 = 0;
                        }
                    }
                }
                aux = aux / 2;
            }
            return tablas;
        }

        public List<char> Evaluar(List<char> tablas, string postfija, int n, int combinaciones, List<char> variables)
        {
            int posicion = 0;
            char valor, valor1, valor2;
            Stack<char> pila = new Stack<char>();
            List<char> resultado = new List<char>();

            for (int j = 0; j < combinaciones; j++)
            {
                for (int i = 0; i < postfija.Length; i++)
                {
                    if (Char.IsLetter(postfija[i]))
                    {
                        posicion = Posicion(variables, postfija[i]);
                        valor = Valor(tablas, j, combinaciones, posicion);
                        pila.Push(valor);
                    }
                    else
                    {
                        if (postfija[i] == '*' || postfija[i] == '+' || postfija[i] == '>' || postfija[i] == '=')
                        {
                            valor2 = pila.Pop();
                            valor1 = pila.Pop();
                            switch (postfija[i])
                            {
                                case '*':
                                    if (valor1 == 'V' && valor2 == 'V')
                                        pila.Push('V');
                                    else
                                        pila.Push('F');
                                    break;
                                case '+':
                                    if (valor1 == 'F' && valor2 == 'F')
                                        pila.Push('F');
                                    else
                                        pila.Push('V');
                                    break;
                                case '>':
                                    if (valor1 == 'V' && valor2 == 'F')
                                        pila.Push('F');
                                    else
                                        pila.Push('V');
                                    break;
                                case '=':
                                    if ((valor1 == 'V' && valor2 == 'V') || (valor1 == 'F' && valor2 == 'F'))
                                        pila.Push('V');
                                    else
                                        pila.Push('F');
                                    break;
                            }
                        }
                        else
                        {
                            valor2 = pila.Pop();
                            if (valor2 == 'V')
                                pila.Push('F');
                            else
                                pila.Push('V');
                        }
                    }
                }
                resultado.Add(pila.Pop());
            }
            return resultado;
        }

        public int Posicion(List<char> variables, char letra)
        {
            int posicion = 0;
            for (int i = 0; i < variables.Count; i++)
            {
                if (letra == variables[i])
                    posicion = i;
            }
            return posicion;
        }

        public char Valor(List<char> tablas, int pos, int combinaciones, int posicion)
        {
            char x = ' ';
            for (int i = 0; i < tablas.Count; i++)
            {
                x = tablas[(posicion * combinaciones) + pos];
            }
            return x;
        }

        public void Imprimir(List<char> variables, List<char> tablas, int combinaciones, List<char> resultados)
        {
            for (int i = 0; i < variables.Count; i++)
            {
                Console.Write(variables[i] + " ");
            }
            Console.Write("R\n");

            for (int i = 0; i < combinaciones; i++)
            {
                for (int j = 0; j < variables.Count; j++)
                {
                    Console.Write(Valor(tablas, i, combinaciones, j) + " ");
                }
                Console.Write(resultados[i] + "\n");
            }
        }
    }
}