module ActiveSupport
  module Cache
    class ReaderWriterCacheStore 
      attr_accessor :readers,:writers
      class NoReadersDefinedError < StandardError; end
      class NoWritersDefinedError < StandardError; end
      
      def initialize(options)
        self.writers = []
        self.readers = [] 
        
        raise NoReadersDefinedError if options[:writers] && !options[:readers]
        raise NoWritersDefinedError if options[:readers] && !options[:writers]
        
        if !options[:writers] && !options[:readers]
          self.writers << ActiveSupport::Cache.lookup_store(options)
          self.readers << ActiveSupport::Cache.lookup_store(options)
        else          
          options[:readers].each{|reader| self.readers << ActiveSupport::Cache.lookup_store(reader.to_a)}
          options[:writers].each{|writer| self.writers << ActiveSupport::Cache.lookup_store(writer.to_a)}
        end

        @reader_size = readers.size
        @writer_size = writers.size
        @current_reader = 1
        @current_writer = 1
      end

      def method_missing(method,*args, &block)
        if reader_methods.include?(method)
          define_reader_delegator(method,*args,&block)
          send(method,*args,&block)
        elsif writer_methods.include?(method)
          define_writer_delegator(method,*args,&block)
          send(method,*args,&block)
        else
          super
        end
      end
      
      def respond_to?(method,include_private=false)
        (reader_methods+writer_methods+methods).include?(method)
      end
      
    private
    
     
     def reader
       returning readers[@current_reader-1] do
         @current_reader = @current_reader+1 > @reader_size ? 1 : @current_reader+1
       end
     end
     
     def writer
       returning writers[@current_writer-1] do
         @current_writer = @current_writer+1 > @writer_size ? 1 : @current_writer+1
       end
     end
           
      def reader_methods
        [:fetch,:read,:exist?,:stats,:read_multi,:read_entry,:key_matcher]        
      end
      
      def writer_methods
        [:write,:delete,:delete_matched,:decrement,:clear,:increment,:write_entry,:delete_entry]
      end
      
      def define_writer_delegator(method,*args,&block)
        self.class_eval do 
          define_method method do |*args,&block| 
            writer.send(method,*args,&block)
           end
        end
      end
      
      def define_reader_delegator(method,*args,&block)
        self.class_eval do 
          define_method method do |*args,&block| 
            reader.send(method,*args,&block)
           end
        end
      end
    end
  end
end