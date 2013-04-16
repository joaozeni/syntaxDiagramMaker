require 'graphviz'

class syntaxMaker
	def self.makeSyntaxDiagram(ebnfFile)
	end

	def makeSyntaxDiagramNode(syntax)
		g = GraphViz::new( "structs", "type" => "digraph" )
		g.add_nodes("startNode").shape = "point"
		if not (syntax.include?("\"=\"") or syntax.include?("\'=\'"))
			#Slip the X = Y part
			syntaxArr = syntax.split("=")
			name = syntaxArr[0].gsub(" ", "")
			if not (syntax.include?("\"|\"") or syntax.include?("\'|\'"))
				#Split the X1 | X2 | ... | XN part
				ops = syntaxArr[1].split("|")
				ops.each do |option|
					#Now makes the sequencial part
					atualNode = g.get_nodes "startNode"
					optNodes = Array.new
					loopNodes =  Array.new
					optionArr = option.split " "
					handleOption(optionArr, atualNode, optNodes, loopNodes, g)
				end
			end
		end
	end

	#Making the sequencial part
	def handleOption(option, atualNode, optNodes, loopNodes, graph)
		atomic = option[0][0]
		if option[0].size == 1
			option = option[1..option.size]
		else
			option[0] = option[0][1..option[0].size]
		end
		if atomic[0] == '[' #option Start
			optNodes.push atualNode
			handleOption(option, atualNode, optNodes, loopNodes, graph)
		elsif atomic[0] == '{' #loop Start
			loopNodes.push atualNode
			handleOption(option, atualNode, optNodes, loopNodes, graph)
		elsif atomic[0] == '(' #agroup Start
		elsif atomic[0] == ']' #option End
			optNode = optNodes.pop
			graph.add_edge(optNode, atualNode)
			handleOption(option, atualNode, optNodes, loopNodes, graph)
		elsif atomic[0] == '}' #loop End
			loopNode = loopNodes.pop
			graph.add_edge(optNode, atualNode)
			handleOption(option, atualNode, optNodes, loopNodes, graph)
		elsif atomic[0] == ')' #agroup End
		elsif atomic[0] == "\"" or atomic[0] == "\'" #literal
		end
	end
end