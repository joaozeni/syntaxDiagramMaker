require 'graphviz'

class syntaxMaker
	def self.makeSyntaxDiagram(ebnfFile)
	end

	def makeSyntaxDiagramNode(syntax)
		g = GraphViz::new( "structs", "type" => "digraph" )
		g.add_nodes("startNode").shape = "point"
		if not (syntax.include?("\"=\"") or syntax.include?("\'=\'"))
			syntaxArr = syntax.split("=")
			name = syntaxArr[0].gsub(" ", "")
			if not (syntax.include?("\"|\"") or syntax.include?("\'|\'"))
				ops = syntaxArr[1].split("|")
				ops.each do |option|
					atualNode = g.get_nodes("startNode")
					optNode = g.get_nodes("startNode")
					option.split(" ").each do |atomic|
						handleAtomic(atomic, atualNode, g)
					end
				end
			end
		end
	end

	def handleAtomic(atomic, atualNode, graph)
		if atomic[0] == '['
		elsif atomic[0] == '{'
		elsif atomic[0] == '('
		elsif atomic[0] == "\"" or atomic[0] == "\'"
		end
	end
end