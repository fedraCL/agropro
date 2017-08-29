class NavieraController < ApplicationController
  before_action :authenticate_user!
  
  def parseHTML_APL(page)
    doc = Nokogiri::HTML(page)
   # puts doc
    #titulos
    table = doc.css('table')

    routing = table[2]
    container = table[3]
    puts "===========================================================" 

    # get table headers
    headers = []
    routing.css('th').each do |th|
      headers << th.text
    end
   # puts headers.to_s


    # get table rows
    rows = []
    routing.css('tr').each_with_index do |row, i|

      rows[i] = {}
      row.xpath('td').each_with_index do |td, j|
        rows[i][headers[j]] = td.text
      end
    end

    rows.each do |fila|
      puts fila
    end

    @resultado  = rows
    render :json => @resultado
    
  end
  
  
  def parseHTML_APL_int(page)
    doc = Nokogiri::HTML(page)
   # puts doc
    #titulos
    table = doc.css('table')

    routing = table[2]
    container = table[3]
    puts "===========================================================" 

    # get table headers
    headers = []
    routing.css('th').each do |th|
      headers << th.text
    end
   # puts headers.to_s


    # get table rows
    rows = []
    routing.css('tr').each_with_index do |row, i|

      rows[i] = {}
      row.xpath('td').each_with_index do |td, j|
        rows[i][headers[j]] = td.text
      end
    end

    rows.each do |fila|
      puts fila
    end

    @resultado  = rows
    #render :json => @resultado
    return @resultado
  end
  
  
  
  
  def parseHTML_CMA(page)
    doc = Nokogiri::HTML(page)

    #titulos
    table = doc.xpath('//table[@id="container-moves"]')
    #puts table.to_s

    #routing = table[2]
    container = table[0]
    puts "tabla = " + container.to_s
    
    if container!=nil
      
    
    puts "===========================================================" 

    # get table headers
    headers = []
    container.css('th').each do |th|
      headers << th.text
    end
    puts headers.to_s

    # get table rows
    rows = []
    container.css('tr').each_with_index do |row, i|

      rows[i] = {}
      row.xpath('td').each_with_index do |td, j|
        rows[i][headers[j]] = td.text
      end
    end

    rows.each do |fila|
      puts fila
    end

    @resultado  = rows
   
    render :json => @resultado
  else
    @resultado  = rows
   
    render :json => nil
  end
  end
  
  def apl
    puts "Iniciando WS APL"
    container = params[:container]
    p container.to_s
    
    #A sacar datos de APL
    
    require 'net/http'
    require 'nokogiri'
    require 'pp'
  
    Net::HTTP.start("homeport.apl.com") do |http|
        resp = http.get("/gentrack/trackingMain.do?trackInput01="+container)
        cookie = resp.response['set-cookie'].split('; ')[0]
    
        headers = {
          'Cookie' => cookie,
          'Content-Type' => 'application/x-www-form-urlencoded'
        }
    
    
        open("page.html", "wb") do |file|
      
            resp1 = http.get("/gentrack/containerTrackingFrame.do",headers)
          #  file.write(resp1.body)
          parseHTML_APL(resp1.body)
        end
    end

    
  end
  
  
  def apl_container(container)
    puts "Iniciando WS APL"
   
    p container.to_s
    
    #A sacar datos de APL
    
    require 'net/http'
    require 'nokogiri'
    require 'pp'
  
    Net::HTTP.start("homeport.apl.com") do |http|
        resp = http.get("/gentrack/trackingMain.do?trackInput01="+container)
        cookie = resp.response['set-cookie'].split('; ')[0]
    
        headers = {
          'Cookie' => cookie,
          'Content-Type' => 'application/x-www-form-urlencoded'
        }
    
    
        open("page.html", "wb") do |file|
      
            resp1 = http.get("/gentrack/containerTrackingFrame.do",headers)
          #  file.write(resp1.body)
          parseHTML_APL_int(resp1.body)
        end
    end

    
  end
  
  ################################
  def all_container(container)
    
   #cma
   resultado = cma_container(container)
 final = Hash.new
  
  
   begin
     p resultado[2]["Date"]
     largo = resultado.count
     puts "ultima fila " +  resultado.count.to_s
     final["VESSEL"] = resultado[largo-2]["Vessel"]
     final["POL"] = resultado[1]["Loc."]
     final["POD"] = resultado[largo-2]["Loc."]
     final["ETD"] = resultado[1]["Date"]
     final["ETA"] = resultado[largo-2]["Date"]
     final["NAVIERA"] = "CMA CGM"
   rescue
     p "CODIGO NO ENCONTRADO"
   end
   
   
   paso = final["VESSEL"].to_s.strip!
 
 if (paso == "")
     puts "Vamos a buscar APL"
  
   #apl
   resultado_apl = apl_container(container)
   puts "APL RESULTADO : " + resultado_apl.to_s
   begin
    largo = resultado_apl.count
   
    puts "ultima fila " +  resultado_apl.count.to_s
    
    puts "POL" + resultado_apl[1]["Location"].to_s
    puts "ETD" + resultado_apl[1]["Container Arrival Date "].to_s
    puts "ETA" + resultado_apl[largo-2]["Container Arrival Date "].to_s
    puts "POD" + resultado_apl[largo-2]["Location"].to_s
    puts "VESSEL" + 
    
    final["VESSEL"] = resultado_apl[largo-2]["Vessel/Voyage"].to_s
    final["POL"] = resultado_apl[1]["Location"].to_s
    final["POD"] = resultado_apl[largo-2]["Location"].to_s
    final["ETD"] = resultado_apl[1]["Container Arrival Date "].to_s
  final["ETA"] = resultado_apl[largo-2]["Container Arrival Date "].to_s
    final["NAVIERA"] = "APL"
   rescue
     p "CODIGO NO ENCONTRADO"
   end
 end
    
     paso = final["VESSEL"].to_s 
     puts "Valor paso = [" + paso + "]"
     
     if (paso == "")
    #hamburg(container)
     resultado_ham = hamburg(container)
     puts "resultado HAM => " + resultado_ham.to_s
     largo = resultado_ham.count
     puts "TOTAL => " + resultado_ham.count.to_s
      puts "ETD = " + resultado_ham[largo-1]["Date"].to_s
      puts "POL = " + resultado_ham[largo-1]["Place"].to_s
      puts "ETA = " + resultado_ham[1]["Date"].to_s
      puts "POD= " + resultado_ham[1]["Place"].to_s
      puts "VESSEL= " +    resultado_ham[1]["Mode/Vendor"].to_s 
      final["VESSEL"] = resultado_ham[1]["Mode/Vendor"].to_s 
      final["POL"] = resultado_ham[largo-1]["Place"].to_s
      final["POD"] = resultado_ham[1]["Place"].to_s
      final["ETD"] = resultado_ham[largo-1]["Date"].to_s
      final["ETA"] = resultado_ham[1]["Date"].to_s
      final["NAVIERA"] = "Hamburg Sud"
      
   
    end
   
   
   
    #buscar vessel
    
    begin  
      b = final["VESSEL"].to_s
      b = b.slice(0, 20)
      
      puts "barco::::::: ["+  b + "]"
      
      barco = vessel(b)
      puts "barcos lista : " + barco.count.to_s
      lista = barco["Lat/Lon"].split("/")
      final["LATITUD"] = lista[0][0..-3]
      final["LONGITUD"] = lista[1][0..-3]
    rescue
      p "VESSEL NO ENCONTRADO"
   end
    
   
    
    
    
   
    return final
    
    
  end
  ################################
  
  
  def cma_container(container)
    require 'net/http'
    require 'nokogiri'
    require 'pp'
    
   
    Net::HTTP.start("www.cma-cgm.com") do |http|
        resp = http.get("/ebusiness/tracking/search?SearchBy=Container&Reference="+container.to_s+"&search=Search")
         puts "esto trae: " + resp.body
          
          doc = Nokogiri::HTML(resp.body)

          #titulos
          table = doc.xpath('//table[@id="container-moves"]')
          #puts table.to_s

          #routing = table[2]
          container = table[0]
          #puts "tabla = " + container.to_s
    
          if container!=nil
      
    
          puts "===========================================================" 

          # get table headers
          headers = []
          container.css('th').each do |th|
            headers << th.text
          end
          #puts headers.to_s

          # get table rows
          rows = []
          container.css('tr').each_with_index do |row, i|

            rows[i] = {}
            row.xpath('td').each_with_index do |td, j|
              rows[i][headers[j]] = td.text
            end
          end

          rows.each do |fila|
            #puts fila
          end

          @resultado  = rows
          return @resultado
         
        else
          @resultado  = rows
          return @resultado
         
        end
    end
  
  end
  
  
  def  cma
    puts "llegue"
    
    require 'net/http'
    require 'nokogiri'
    require 'pp'
    container = params[:container]
   
    Net::HTTP.start("www.cma-cgm.com") do |http|
        resp = http.get("/ebusiness/tracking/search?SearchBy=Container&Reference="+container.to_s+"&search=Search")
        puts "esto trae: " + resp.body
          parseHTML_CMA(resp.body)
    end
  
  end
  
  def getDetails(url)
    p "Buscando detalle : " + url
    p url
  
    response = Net::HTTP.get_response(URI(url))
    parseDetails(response.body)
  
  end

  def parseDetails(page)
    #p "detalle :: " + page.to_s
    doc = Nokogiri::HTML(page)
    data =  doc.css("div.row.param")
    #data =  doc.xpath("id('ais-data')")
  
  
    resultado = {}
  
  
    data.each do |dato|
      a = dato.to_s.gsub(/<\/?[^>]*>/, "")
      dataok = a.to_s.chop!.strip
    
      values = dataok.split(":")
    
     # p  values[0].to_s.strip + ":"  + values[1].to_s.strip
    
      resultado[values[0].to_s.strip] = values[1].to_s.strip
    
   
    end
  
    return resultado
  

  end




  def parseHTML_vessel(page)
      r = {}
    doc = Nokogiri::HTML(page)
    #puts doc
    #titulos
    table = doc.css('article')
    #puts table.to_s
  
    i = 0
    table.each do |barco|
      puts "barco ================" + i.to_s
      #p barco.to_s
      links = barco.css('a')
      c = 0
      #link para ubicación
  
      trozo =   links[1]
      doc1 = Nokogiri::HTML(trozo.to_s.gsub(/\s/, ' '))
      l = doc1.css('a').map { |link| link['href'] }
   
    
      #get details
    
      l.each do |ll|
     #   p ll
        url = "https://www.vesselfinder.com" + ll
        p getDetails(url).to_s
        r = r.merge(getDetails(url))
      end
    
    
    
      i = i +1
    end
    @resultado  = r
    render :json => @resultado
  
  end
  
  def parseHTML_vessel_int(page)
      r = {}
    doc = Nokogiri::HTML(page)
    #puts doc
    #titulos
    table = doc.css('article')
    #puts table.to_s
  
    i = 0
    table.each do |barco|
      puts "barco ================" + i.to_s
      #p barco.to_s
      links = barco.css('a')
      c = 0
      #link para ubicación
  
      trozo =   links[1]
      doc1 = Nokogiri::HTML(trozo.to_s.gsub(/\s/, ' '))
      l = doc1.css('a').map { |link| link['href'] }
   
    
      #get details
    
      l.each do |ll|
     #   p ll
        url = "https://www.vesselfinder.com" + ll
        p getDetails(url).to_s
        r = r.merge(getDetails(url))
      end
    
    
    
      i = i +1
    end
        puts "TOTAL BARCOS : " +r.count.to_s
    #render :json => @resultado
    return r
  end
  
  
  
  
  def get_response_with_redirect(uri)
     r = Net::HTTP.get_response(uri)
     if r.code == "301"
       r = Net::HTTP.get_response(URI.parse(r.header['location']))
     end
     r
  end
  
  
  def vessel
    vessel = params[:vessel]
    response = Net::HTTP.get_response(URI('https://www.vesselfinder.com/vessels?name='+vessel))
    parseHTML_vessel(response.body)
  end
  
  def vessel(barco)
    
    puts "A Buscar Barco......." + barco
   
    begin
      barco["APL USE-"]= ""
    rescue
      vessel = barco.to_s
    end
    vessel = barco.to_s
    
    
    url = 'https://www.vesselfinder.com/vessels?name='+vessel
    puts "URL => " + url
    
    response = Net::HTTP.get_response(URI('https://www.vesselfinder.com/vessels?name='+vessel))
    return parseHTML_vessel_int(response.body)
  end
  
  
  def nyk
    require "net/http"
    require 'net/https'
    require "uri"
    require 'json'

    cop_no = ""
    id_container = params[:container]

    #https://www.nykline.com/ecom/CUP_HOM_3301GS.do?_search=false&rows=10000&page=1&sidx=&sord=asc&f_cmd=121&search_type=A&search_name=DRYU9475289&cust_cd=

    #primero buscamos cop_no
    cop_no = cop_no(id_container)

    uri = URI.parse("https://www.nykline.com/ecom/CUP_HOM_3301GS.do")
    https = Net::HTTP.new("www.nykline.com",443)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)

    data = {
      "f_cmd" => "125",
      "cntr_no" => id_container,
      "bkg_no" => "",
      "cop_no"=> cop_no
    }

    req.set_form_data(data)
    res = https.request(req)

    salida  = JSON.parse(res.body)
    @resultado = salida
    render :json => @resultado
    puts salida
    
  end
  
  def cop_no(container)
    puts "buscando cop no"
    Net::HTTP.start("www.nykline.com") do |http|
        resp = http.get("/ecom/CUP_HOM_3301GS.do?_search=false&rows=10000&page=1&sidx=&sord=asc&f_cmd=121&search_type=A&search_name="+container+"&cust_cd=")
     
        data_hash = JSON.parse(resp.body)
        puts data_hash['list'][0]['copNo']
        return data_hash['list'][0]['copNo']
      end
  end

  def parseHTML_ham(page)
    puts page
    
    doc = Nokogiri::HTML(page)
 
    #titulos
    table = doc.xpath('//table[@id="j_idt35:j_idt53:containerDetails"]')
    #puts table.to_s
    tabla = table[0]
    # get table headers
    headers = []
    tabla.css('th').each do |th|
      headers << th.text
    end
    #puts headers.to_s
  
  
    # get table rows
    rows = []
    tabla.css('tr').each_with_index do |row, i|
  
      rows[i] = {}
      row.xpath('td').each_with_index do |td, j|
        rows[i][headers[j]] = td.text
      end
    end

    rows.each do |fila|
      puts fila
    end
    
    
    return rows
  end
  

  def hamburg(container)
    require 'net/http'
    require 'net/https'
    require 'nokogiri'
    require 'pp'
    http = Net::HTTP.new('www.ecom.hamburgsud.com', 80)
    http.use_ssl = false
    http.ssl_version = :SSLv3
    http.ciphers = "ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:-LOW"
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    req = Net::HTTP::Get.new('/ecom/en/ecommerce_portal/track_trace/track__trace/ep_tracktrace_results.xhtml?lang=EN&searchReference=' + container)
    page = ""
    http.start {|http| page = http.request(req).body }

    return parseHTML_ham(page)
  end



  
end
